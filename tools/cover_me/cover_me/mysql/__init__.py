"""
Dump MySQL stored procedure/function definitions from information_schema.
"""
import json
from pathlib import Path
from cover_me.models import ProcedureDef, cache_source, load_cached_source, load_cached_meta


DUMP_SQL = """
SELECT
    r.SPECIFIC_NAME                          AS oid,
    r.ROUTINE_SCHEMA                         AS `schema`,
    r.ROUTINE_NAME                           AS name,
    COALESCE(r.IS_DETERMINISTIC, 'NO')       AS `deterministic`,
    COALESCE(r.SQL_DATA_ACCESS, 'CONTAINS SQL') AS `data_access`,
    COALESCE(r.SECURITY_TYPE, 'DEFINER')     AS `security_type`,
    r.ROUTINE_TYPE                            AS `routine_type`,
    r.DTD_IDENTIFIER                          AS `return_type`,
    r.ROUTINE_DEFINITION                      AS `source`
FROM information_schema.ROUTINES AS r
WHERE r.ROUTINE_SCHEMA NOT IN ('sys', 'mysql', 'information_schema', 'performance_schema', 'tap', 'cover_me')
  AND r.ROUTINE_BODY = 'SQL'
  AND r.ROUTINE_DEFINITION IS NOT NULL
  AND r.ROUTINE_NAME NOT LIKE 'cover_me_%'
ORDER BY r.ROUTINE_SCHEMA, r.ROUTINE_NAME;
"""


def _parse_row(row: dict) -> ProcedureDef:
    """Convert a query result row to a ProcedureDef."""
    return ProcedureDef(
        oid=row["oid"],
        schema=row["schema"],
        name=row["name"],
        source=row["source"].strip() if row["source"] else "",
        is_strict=row["deterministic"] == "YES",
        is_secdef=row["security_type"] == "DEFINER",
        is_setof=False,
        return_type=row["return_type"] or "void",
        volatility=row["data_access"],
        arg_modes=[],
        arg_names=[],
        arg_types=[],
    )


def dump_procedures(connection) -> list[ProcedureDef]:
    """Fetch all stored procedures/functions from MySQL."""
    with connection.cursor(dictionary=True) as cur:
        cur.execute(DUMP_SQL)
        return [_parse_row(row) for row in cur.fetchall()]
