"""
Install/uninstall instrumented procedures and helper objects in MySQL.
"""
from pathlib import Path
from cover_me.models import ProcedureDef, load_cached_source, load_cached_meta


# MyISAM trace table — inserts survive ROLLBACK (non-transactional engine)
SETUP_SQL = """
CREATE DATABASE IF NOT EXISTS cover_me;

CREATE TABLE IF NOT EXISTS cover_me.trace (
    id        BIGINT AUTO_INCREMENT PRIMARY KEY,
    tag_id    VARCHAR(16) NOT NULL,
    value     CHAR(1) NULL,
    hit_when  DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())
) ENGINE=MyISAM;

TRUNCATE TABLE cover_me.trace;
"""

# Helper function for conditional coverage
HELPER_COND_SQL = (
    "CREATE FUNCTION cover_me.cover_me_cond(p_tag VARCHAR(16), p_val BOOLEAN) "
    "RETURNS BOOLEAN DETERMINISTIC NO SQL "
    "BEGIN "
    "IF p_val THEN "
    "INSERT INTO cover_me.trace (tag_id, value) VALUES (p_tag, 't'); "
    "ELSE "
    "INSERT INTO cover_me.trace (tag_id, value) VALUES (p_tag, 'f'); "
    "END IF; "
    "RETURN p_val; "
    "END"
)

TEARDOWN_SQL = """
DROP FUNCTION IF EXISTS cover_me.cover_me_cond;
DROP TABLE IF EXISTS cover_me.trace;
DROP DATABASE IF EXISTS cover_me;
"""


def _get_create_sql(connection, proc: ProcedureDef) -> str | None:
    """Get the full CREATE statement for a procedure/function via SHOW CREATE."""
    with connection.cursor(dictionary=True) as cur:
        try:
            if proc.return_type and proc.return_type != "void":
                cur.execute(f"SHOW CREATE FUNCTION `{proc.schema}`.`{proc.name}`")
                row = cur.fetchone()
                return row.get("Create Function") if row else None
            else:
                cur.execute(f"SHOW CREATE PROCEDURE `{proc.schema}`.`{proc.name}`")
                row = cur.fetchone()
                return row.get("Create Procedure") if row else None
        except Exception:
            return None


def install_helpers(connection) -> None:
    """Install trace table and helper function."""
    cur = connection.cursor()
    cur.execute("CREATE DATABASE IF NOT EXISTS cover_me")
    cur.execute(
        "CREATE TABLE IF NOT EXISTS cover_me.trace ("
        "id BIGINT AUTO_INCREMENT PRIMARY KEY,"
        "tag_id VARCHAR(16) NOT NULL,"
        "value CHAR(1) NULL,"
        "hit_when DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())"
        ") ENGINE=MyISAM"
    )
    cur.execute("TRUNCATE TABLE cover_me.trace")
    cur.execute("DROP FUNCTION IF EXISTS cover_me.cover_me_cond")
    cur.execute(HELPER_COND_SQL)
    cur.close()
    connection.commit()


def uninstall_helpers(connection) -> None:
    """Remove trace table and helper function."""
    cur = connection.cursor()
    cur.execute("DROP FUNCTION IF EXISTS cover_me.cover_me_cond")
    cur.execute("DROP TABLE IF EXISTS cover_me.trace")
    cur.execute("DROP DATABASE IF EXISTS cover_me")
    cur.close()
    connection.commit()


def install_instrumented(connection, proc: ProcedureDef, instrumented_source: str) -> bool:
    """Replace a procedure/function with its instrumented version."""
    create_sql = _get_create_sql(connection, proc)
    if not create_sql:
        print(f"  WARNING: Could not get CREATE for {proc.qualified_name}", flush=True)
        return False

    original_body = proc.source
    if original_body not in create_sql:
        print(f"  WARNING: Could not find body in CREATE for {proc.qualified_name}", flush=True)
        return False

    new_sql = create_sql.replace(original_body, instrumented_source, 1)
    # Instrumented code inserts into trace table — must allow SQL data access
    for old_access in ("NO SQL", "READS SQL DATA"):
        new_sql = new_sql.replace(old_access, "MODIFIES SQL DATA", 1)
    # Ensure schema is qualified (SHOW CREATE may omit it)
    new_sql = new_sql.replace(
        f"FUNCTION `{proc.name}`",
        f"FUNCTION `{proc.schema}`.`{proc.name}`",
        1
    )
    new_sql = new_sql.replace(
        f"PROCEDURE `{proc.name}`",
        f"PROCEDURE `{proc.schema}`.`{proc.name}`",
        1
    )

    with connection.cursor() as cur:
        try:
            if proc.return_type and proc.return_type != "void":
                cur.execute(f"DROP FUNCTION IF EXISTS `{proc.schema}`.`{proc.name}`")
            else:
                cur.execute(f"DROP PROCEDURE IF EXISTS `{proc.schema}`.`{proc.name}`")
            cur.execute(new_sql)
            connection.commit()
            return True
        except Exception as e:
            connection.rollback()
            # DROP already committed (DDL is auto-commit in MySQL)
            # Restore the original to avoid leaving the function missing
            try:
                cur.execute(create_sql)
                connection.commit()
                print(f"  WARNING: Could not instrument {proc.qualified_name}: {e} (original restored)", flush=True)
            except Exception:
                print(f"  WARNING: Could not instrument {proc.qualified_name}: {e} (RESTORE FAILED)", flush=True)
            return False


def restore_original(connection, proc_oid: str, cache_dir: Path) -> bool:
    """Restore a procedure/function from cached CREATE statement."""
    meta = load_cached_meta(proc_oid, cache_dir)
    create_path = cache_dir / proc_oid / "create.sql"
    if meta is None or not create_path.exists():
        return False

    create_sql = create_path.read_text()
    schema = meta["schema"]
    name = meta["name"]
    return_type = meta.get("return_type", "")

    with connection.cursor() as cur:
        try:
            if return_type and return_type != "void":
                cur.execute(f"DROP FUNCTION IF EXISTS `{schema}`.`{name}`")
            else:
                cur.execute(f"DROP PROCEDURE IF EXISTS `{schema}`.`{name}`")
            cur.execute(create_sql)
            connection.commit()
            return True
        except Exception as e:
            connection.rollback()
            print(f"  WARNING: Could not restore {schema}.{name}: {e}", flush=True)
            return False


def cache_create_sql(connection, proc: ProcedureDef, cache_dir: Path) -> None:
    """Cache the full CREATE statement for later restoration."""
    create_sql = _get_create_sql(connection, proc)
    if create_sql:
        proc_dir = cache_dir / proc.oid
        proc_dir.mkdir(parents=True, exist_ok=True)
        (proc_dir / "create.sql").write_text(create_sql)
