"""
Tests for the dumper and installer modules.
Uses mocks — no database connection required.
"""
import json
import pytest
from pathlib import Path
from unittest.mock import MagicMock, call

from cover_me.models import (
    ProcedureDef, cache_source,
    load_cached_source, load_cached_meta,
)
from cover_me.pg.dumper import _parse_row
from cover_me.pg.installer import (
    _build_create_function_sql, HELPER_SQL, DROP_HELPERS_SQL,
    install_helpers, uninstall_helpers,
)


# ---------------------------------------------------------------------------
# ProcedureDef tests
# ---------------------------------------------------------------------------

class TestProcedureDef:

    def test_qualified_name(self):
        proc = ProcedureDef(
            oid="123", schema="hr", name="get_employee",
            source="BEGIN END;", is_strict=False, is_secdef=False,
            is_setof=False, return_type="void", volatility="VOLATILE",
            arg_modes=[], arg_names=[], arg_types=[],
        )
        assert proc.qualified_name == "hr.get_employee"

    def test_signature_no_args(self):
        proc = ProcedureDef(
            oid="123", schema="hr", name="get_all",
            source="", is_strict=False, is_secdef=False,
            is_setof=False, return_type="void", volatility="VOLATILE",
            arg_modes=[], arg_names=[], arg_types=[],
        )
        assert proc.signature == "hr.get_all()"

    def test_signature_with_args(self):
        proc = ProcedureDef(
            oid="123", schema="hr", name="get_emp",
            source="", is_strict=False, is_secdef=False,
            is_setof=False, return_type="integer", volatility="STABLE",
            arg_modes=["IN", "IN"], arg_names=["p_id", "p_name"],
            arg_types=["integer", "text"],
        )
        assert "IN p_id integer" in proc.signature
        assert "IN p_name text" in proc.signature


# ---------------------------------------------------------------------------
# Row parsing tests
# ---------------------------------------------------------------------------

class TestParseRow:

    def test_basic_row(self):
        row = {
            "oid": "12345", "schema": "public", "name": "my_func",
            "strict": False, "secdef": False, "volatility": "v",
            "setof": False, "return_type": "void",
            "source": "  BEGIN\n  END;  ",
            "arg_count": "2", "arg_modes": "i,i",
            "arg_names": "a,b", "arg_types": "integer,text",
        }
        proc = _parse_row(row)
        assert proc.oid == "12345"
        assert proc.schema == "public"
        assert proc.source == "BEGIN\n  END;"  # stripped
        assert proc.volatility == "VOLATILE"
        assert proc.arg_modes == ["IN", "IN"]
        assert proc.arg_names == ["a", "b"]
        assert proc.arg_types == ["integer", "text"]

    def test_no_args(self):
        row = {
            "oid": "99", "schema": "s", "name": "f",
            "strict": True, "secdef": False, "volatility": "i",
            "setof": False, "return_type": "integer",
            "source": "BEGIN RETURN 1; END;",
            "arg_count": "0", "arg_modes": "", "arg_names": "", "arg_types": "",
        }
        proc = _parse_row(row)
        assert proc.arg_modes == []
        assert proc.arg_names == []
        assert proc.volatility == "IMMUTABLE"
        assert proc.is_strict is True


# ---------------------------------------------------------------------------
# Cache tests
# ---------------------------------------------------------------------------

class TestCache:

    def test_cache_and_load(self, tmp_path):
        proc = ProcedureDef(
            oid="555", schema="hr", name="test_func",
            source="BEGIN\n  RETURN 1;\nEND;",
            is_strict=False, is_secdef=False, is_setof=False,
            return_type="integer", volatility="VOLATILE",
            arg_modes=["IN"], arg_names=["x"], arg_types=["integer"],
        )
        cache_source(proc, tmp_path)

        # Verify source cached
        source = load_cached_source("555", tmp_path)
        assert source == proc.source

        # Verify metadata cached
        meta = load_cached_meta("555", tmp_path)
        assert meta["oid"] == "555"
        assert meta["schema"] == "hr"
        assert meta["name"] == "test_func"
        assert meta["arg_names"] == ["x"]

    def test_load_missing_returns_none(self, tmp_path):
        assert load_cached_source("999", tmp_path) is None
        assert load_cached_meta("999", tmp_path) is None


# ---------------------------------------------------------------------------
# Installer SQL generation tests
# ---------------------------------------------------------------------------

class TestBuildCreateFunction:

    def test_simple_function(self):
        proc = ProcedureDef(
            oid="1", schema="public", name="add_nums",
            source="BEGIN RETURN a + b; END;",
            is_strict=False, is_secdef=False, is_setof=False,
            return_type="integer", volatility="VOLATILE",
            arg_modes=["IN", "IN"], arg_names=["a", "b"],
            arg_types=["integer", "integer"],
        )
        sql = _build_create_function_sql(proc, proc.source)
        assert "CREATE OR REPLACE FUNCTION public.add_nums" in sql
        assert "IN a integer, IN b integer" in sql
        assert "RETURNS integer" in sql
        assert "$COVER_ME$" in sql
        assert "VOLATILE" in sql

    def test_setof_function(self):
        proc = ProcedureDef(
            oid="2", schema="hr", name="get_all",
            source="BEGIN END;",
            is_strict=True, is_secdef=True, is_setof=True,
            return_type="record", volatility="STABLE",
            arg_modes=[], arg_names=[], arg_types=[],
        )
        sql = _build_create_function_sql(proc, proc.source)
        assert "RETURNS SETOF record" in sql
        assert "STRICT" in sql
        assert "SECURITY DEFINER" in sql
        assert "STABLE" in sql

    def test_no_args(self):
        proc = ProcedureDef(
            oid="3", schema="s", name="f",
            source="BEGIN END;",
            is_strict=False, is_secdef=False, is_setof=False,
            return_type="void", volatility="VOLATILE",
            arg_modes=[], arg_names=[], arg_types=[],
        )
        sql = _build_create_function_sql(proc, proc.source)
        assert "s.f()" in sql


# ---------------------------------------------------------------------------
# Helper install/uninstall tests (mocked connection)
# ---------------------------------------------------------------------------

class TestHelperInstall:

    def test_install_helpers(self):
        conn = MagicMock()
        cur = MagicMock()
        conn.cursor.return_value.__enter__ = MagicMock(return_value=cur)
        conn.cursor.return_value.__exit__ = MagicMock(return_value=False)

        install_helpers(conn)
        cur.execute.assert_called_once_with(HELPER_SQL)
        conn.commit.assert_called_once()

    def test_uninstall_helpers(self):
        conn = MagicMock()
        cur = MagicMock()
        conn.cursor.return_value.__enter__ = MagicMock(return_value=cur)
        conn.cursor.return_value.__exit__ = MagicMock(return_value=False)

        uninstall_helpers(conn)
        cur.execute.assert_called_once_with(DROP_HELPERS_SQL)
        conn.commit.assert_called_once()
