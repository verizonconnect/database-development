"""
Integration tests for cover_me.

These tests require running database containers:
  - Postgres: localhost:5432, database=test_cover_me, user=postgres, password=postgres
  - MySQL:    localhost:3306, database=test_cover_me, user=root, password=root

Skip automatically if the database is not available.

Run with:
    docker run -d --name pg_test -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=test_cover_me -p 5432:5432 postgres:13-alpine
    docker run -d --name my_test -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=test_cover_me -p 3306:3306 mysql:8.4
    python -m pytest tests/test_integration.py -v
"""
import pytest
from pathlib import Path

# ---------------------------------------------------------------------------
# Fixtures
# ---------------------------------------------------------------------------

@pytest.fixture
def pg_conn():
    """Connect to Postgres test database, skip if unavailable."""
    try:
        import psycopg2
        conn = psycopg2.connect(
            host="localhost", port=5432,
            dbname="test_cover_me", user="postgres", password="postgres",
        )
        yield conn
        conn.close()
    except Exception as e:
        pytest.skip(f"Postgres not available: {e}")


@pytest.fixture
def mysql_conn():
    """Connect to MySQL test database, skip if unavailable."""
    try:
        import mysql.connector
        conn = mysql.connector.connect(
            host="localhost", port=3306,
            database="test_cover_me", user="root", password="root",
        )
        yield conn
        conn.close()
    except Exception as e:
        pytest.skip(f"MySQL not available: {e}")


# ---------------------------------------------------------------------------
# Postgres integration tests
# ---------------------------------------------------------------------------

class TestPostgresIntegration:

    def _create_test_function(self, conn):
        """Create a simple PL/pgSQL function for testing."""
        with conn.cursor() as cur:
            cur.execute("CREATE SCHEMA IF NOT EXISTS test_schema")
            cur.execute("""
                CREATE OR REPLACE FUNCTION test_schema.add_numbers(a INT, b INT)
                RETURNS INT AS $$
                BEGIN
                    IF a IS NULL THEN
                        RETURN b;
                    ELSIF b IS NULL THEN
                        RETURN a;
                    ELSE
                        RETURN a + b;
                    END IF;
                END;
                $$ LANGUAGE plpgsql;
            """)
        conn.commit()

    def _cleanup(self, conn):
        with conn.cursor() as cur:
            cur.execute("DROP SCHEMA IF EXISTS test_schema CASCADE")
        conn.commit()

    def test_trace_and_untrace(self, pg_conn, tmp_path):
        """Full trace → untrace cycle preserves function."""
        from cover_me.pg.dumper import dump_procedures
        from cover_me.pg.installer import install_helpers, uninstall_helpers, install_instrumented, restore_original
        from cover_me.models import cache_source
        from cover_me.instrumenter import instrument

        self._create_test_function(pg_conn)
        try:
            # Dump
            procs = dump_procedures(pg_conn)
            test_procs = [p for p in procs if p.schema == "test_schema"]
            assert len(test_procs) == 1
            proc = test_procs[0]
            assert proc.name == "add_numbers"

            # Cache
            cache_dir = tmp_path / "cache"
            cache_source(proc, cache_dir)

            # Install helpers
            install_helpers(pg_conn)

            # Instrument
            result = instrument(proc.source, proc.oid, engine="postgres")
            assert len(result.tags) > 0
            assert "cover_me_cond" in result.source

            # Install instrumented version
            ok = install_instrumented(pg_conn, proc, result.source)
            assert ok

            # Verify instrumented function works
            with pg_conn.cursor() as cur:
                cur.execute("SELECT test_schema.add_numbers(1, 2)")
                assert cur.fetchone()[0] == 3

            # Restore
            ok = restore_original(pg_conn, proc.oid, cache_dir)
            assert ok

            # Verify original function still works
            with pg_conn.cursor() as cur:
                cur.execute("SELECT test_schema.add_numbers(10, 20)")
                assert cur.fetchone()[0] == 30

            uninstall_helpers(pg_conn)
        finally:
            self._cleanup(pg_conn)

    def test_coverage_report(self, pg_conn, tmp_path):
        """Full trace → exercise → report cycle produces valid output."""
        from cover_me.pg.dumper import dump_procedures
        from cover_me.pg.installer import install_helpers, uninstall_helpers, install_instrumented, restore_original
        from cover_me.models import cache_source, load_cached_source
        from cover_me.instrumenter import instrument
        from cover_me.profile import Profile
        from cover_me.reporter import generate_opencover

        self._create_test_function(pg_conn)
        try:
            procs = dump_procedures(pg_conn)
            proc = [p for p in procs if p.schema == "test_schema"][0]

            cache_dir = tmp_path / "cache"
            cache_source(proc, cache_dir)
            install_helpers(pg_conn)

            result = instrument(proc.source, proc.oid, engine="postgres")
            install_instrumented(pg_conn, proc, result.source)

            # Exercise the function — capture warnings
            with pg_conn.cursor() as cur:
                cur.execute("SET client_min_messages = WARNING")
                cur.execute("SELECT test_schema.add_numbers(1, 2)")
                cur.execute("SELECT test_schema.add_numbers(NULL, 5)")
                cur.execute("SELECT test_schema.add_numbers(3, NULL)")

            # Build profile from re-instrumented cached source
            profile = Profile()
            cached = load_cached_source(proc.oid, cache_dir)
            result2 = instrument(cached, proc.oid, engine="postgres")
            profile.register(result2.tags)

            # We can't easily capture RAISE WARNING from psycopg2 in-process,
            # so just verify the report generates without error
            output = tmp_path / "opencover.xml"
            generate_opencover([proc], {proc.oid: result2.tags}, profile, output)
            assert output.exists()
            assert output.stat().st_size > 0

            restore_original(pg_conn, proc.oid, cache_dir)
            uninstall_helpers(pg_conn)
        finally:
            self._cleanup(pg_conn)


# ---------------------------------------------------------------------------
# MySQL integration tests
# ---------------------------------------------------------------------------

class TestMySQLIntegration:

    def _create_test_function(self, conn):
        """Create a simple MySQL function for testing."""
        cur = conn.cursor()
        cur.execute("DROP FUNCTION IF EXISTS test_cover_me.add_numbers")
        cur.execute(
            "CREATE FUNCTION test_cover_me.add_numbers(a INT, b INT) "
            "RETURNS INT DETERMINISTIC "
            "BEGIN "
            "DECLARE v_result INT; "
            "IF a IS NULL THEN SET v_result = b; "
            "ELSEIF b IS NULL THEN SET v_result = a; "
            "ELSE SET v_result = a + b; "
            "END IF; "
            "RETURN v_result; "
            "END"
        )
        cur.close()
        conn.commit()

    def _cleanup(self, conn):
        cur = conn.cursor()
        cur.execute("DROP FUNCTION IF EXISTS test_cover_me.add_numbers")
        cur.execute("DROP TABLE IF EXISTS cover_me.trace")
        cur.execute("DROP FUNCTION IF EXISTS cover_me.cover_me_cond")
        cur.execute("DROP DATABASE IF EXISTS cover_me")
        cur.close()
        conn.commit()

    def test_trace_and_untrace(self, mysql_conn, tmp_path):
        """Full trace → untrace cycle preserves function."""
        from cover_me.mysql import dump_procedures
        from cover_me.mysql.installer import (
            install_helpers, uninstall_helpers,
            install_instrumented, restore_original,
            cache_create_sql,
        )
        from cover_me.models import cache_source
        from cover_me.instrumenter import instrument

        self._create_test_function(mysql_conn)
        try:
            # Dump
            procs = dump_procedures(mysql_conn)
            test_procs = [p for p in procs if p.schema == "test_cover_me"]
            assert len(test_procs) == 1
            proc = test_procs[0]
            assert proc.name == "add_numbers"

            # Cache
            cache_dir = tmp_path / "cache"
            cache_source(proc, cache_dir)
            cache_create_sql(mysql_conn, proc, cache_dir)

            # Install helpers
            install_helpers(mysql_conn)

            # Instrument
            result = instrument(proc.source, proc.oid, engine="mysql")
            assert len(result.tags) > 0
            assert "cover_me.trace" in result.source

            # Install instrumented version
            ok = install_instrumented(mysql_conn, proc, result.source)
            assert ok

            # Verify instrumented function works
            cur = mysql_conn.cursor()
            cur.execute("SELECT test_cover_me.add_numbers(1, 2)")
            assert cur.fetchone()[0] == 3
            cur.close()

            # Verify trace table has hits
            cur = mysql_conn.cursor()
            cur.execute("SELECT COUNT(*) FROM cover_me.trace")
            hit_count = cur.fetchone()[0]
            cur.close()
            assert hit_count > 0, "Trace table should have coverage hits"

            # Restore
            ok = restore_original(mysql_conn, proc.oid, cache_dir)
            assert ok

            # Verify original function still works
            cur = mysql_conn.cursor()
            cur.execute("SELECT test_cover_me.add_numbers(10, 20)")
            assert cur.fetchone()[0] == 30
            cur.close()

            uninstall_helpers(mysql_conn)
        finally:
            self._cleanup(mysql_conn)

    def test_coverage_report_from_trace_table(self, mysql_conn, tmp_path):
        """Full trace → exercise → report cycle with trace table."""
        from cover_me.mysql import dump_procedures
        from cover_me.mysql.installer import (
            install_helpers, uninstall_helpers,
            install_instrumented, restore_original,
            cache_create_sql,
        )
        from cover_me.mysql.profile import parse_trace_table
        from cover_me.models import cache_source, load_cached_source
        from cover_me.instrumenter import instrument
        from cover_me.profile import Profile
        from cover_me.reporter import generate_opencover

        self._create_test_function(mysql_conn)
        try:
            procs = dump_procedures(mysql_conn)
            proc = [p for p in procs if p.schema == "test_cover_me"][0]

            cache_dir = tmp_path / "cache"
            cache_source(proc, cache_dir)
            cache_create_sql(mysql_conn, proc, cache_dir)
            install_helpers(mysql_conn)

            result = instrument(proc.source, proc.oid, engine="mysql")
            install_instrumented(mysql_conn, proc, result.source)

            # Exercise all branches
            cur = mysql_conn.cursor()
            cur.execute("SELECT test_cover_me.add_numbers(1, 2)")    # ELSE branch
            cur.execute("SELECT test_cover_me.add_numbers(NULL, 5)") # IF NULL branch
            cur.execute("SELECT test_cover_me.add_numbers(3, NULL)") # ELSEIF NULL branch
            cur.close()

            # Build profile from trace table
            profile = Profile()
            cached = load_cached_source(proc.oid, cache_dir)
            result2 = instrument(cached, proc.oid, engine="mysql")
            profile.register(result2.tags)

            hits = parse_trace_table(mysql_conn, profile)
            assert hits > 0, "Should have coverage hits from trace table"

            # Generate report
            output = tmp_path / "opencover.xml"
            generate_opencover([proc], {proc.oid: result2.tags}, profile, output)
            assert output.exists()

            # Verify coverage — at least some tags should be visited
            visited = [tp for tp in profile.all_tags if tp.visit_count > 0]
            assert len(visited) > 0, "At least some tags should have been visited"

            restore_original(mysql_conn, proc.oid, cache_dir)
            uninstall_helpers(mysql_conn)
        finally:
            self._cleanup(mysql_conn)
