"""
Dump PL/pgSQL function definitions from pg_proc.
"""
import json
import os
from dataclasses import dataclass
from pathlib import Path


@dataclass
class ProcedureDef:
    """A PL/pgSQL function/procedure dumped from the database."""
    oid: str
    schema: str
    name: str
    source: str
    is_strict: bool
    is_secdef: bool
    is_setof: bool
    return_type: str
    volatility: str
    arg_modes: list[str]
    arg_names: list[str]
    arg_types: list[str]

    @property
    def qualified_name(self) -> str:
        return f"{self.schema}.{self.name}"

    @property
    def signature(self) -> str:
        args = ", ".join(
            f"{m} {n} {t}" for m, n, t in
            zip(self.arg_modes, self.arg_names, self.arg_types)
        ) if self.arg_names else ""
        return f"{self.qualified_name}({args})"


_VOLATILITY_MAP = {"i": "IMMUTABLE", "v": "VOLATILE", "s": "STABLE"}
_MODE_MAP = {"i": "IN", "o": "OUT", "b": "INOUT", "v": "VARIADIC", "t": "TABLE"}

# Query to fetch all PL/pgSQL functions (excluding cover_me helpers)
DUMP_SQL = """
SELECT
    pro.oid::text,
    nschema.nspname   AS schema,
    pro.proname       AS name,
    pro.proisstrict   AS strict,
    pro.prosecdef     AS secdef,
    pro.provolatile   AS volatility,
    pro.proretset     AS setof,
    format_type(pro.prorettype, NULL) AS return_type,
    pro.prosrc        AS source,
    pro.pronargs      AS arg_count,
    COALESCE(array_to_string(pro.proargmodes, ','), '') AS arg_modes,
    COALESCE(array_to_string(pro.proargnames, ','), '') AS arg_names,
    COALESCE(
        CASE WHEN proallargtypes IS NOT NULL THEN
            array_to_string(
                ARRAY(SELECT format_type(proallargtypes[k], NULL)
                      FROM generate_series(array_lower(proallargtypes, 1),
                                           array_upper(proallargtypes, 1)) AS k),
                ',')
        ELSE
            oidvectortypes(pro.proargtypes)
        END, '') AS arg_types
FROM pg_proc AS pro
JOIN pg_namespace AS nschema ON pro.pronamespace = nschema.oid
WHERE pro.prolang = (SELECT oid FROM pg_language WHERE lanname = 'plpgsql')
  AND pro.proname NOT LIKE 'cover_me_%'
  AND nschema.nspname NOT LIKE 'pg_%'
  AND nschema.nspname <> 'information_schema'
  AND nschema.nspname <> 'public'
  AND pro.pronamespace NOT IN (
      SELECT oid FROM pg_namespace WHERE nspname IN ('pgtap', 'tap')
  )
ORDER BY nschema.nspname, pro.proname;
"""


def _parse_row(row: dict) -> ProcedureDef:
    """Convert a query result row to a ProcedureDef."""
    arg_count = int(row["arg_count"])
    modes_raw = row["arg_modes"]
    modes = [_MODE_MAP.get(m.strip(), m.strip()) for m in modes_raw.split(",") if m.strip()] if modes_raw else ["IN"] * arg_count
    names = [n.strip() for n in row["arg_names"].split(",") if n.strip()] if row["arg_names"] else []
    types = [t.strip() for t in row["arg_types"].split(",") if t.strip()] if row["arg_types"] else []

    return ProcedureDef(
        oid=row["oid"],
        schema=row["schema"],
        name=row["name"],
        source=row["source"].strip(),
        is_strict=row["strict"],
        is_secdef=row["secdef"],
        is_setof=row["setof"],
        return_type=row["return_type"],
        volatility=_VOLATILITY_MAP.get(row["volatility"], "VOLATILE"),
        arg_modes=modes,
        arg_names=names,
        arg_types=types,
    )


def dump_procedures(connection) -> list[ProcedureDef]:
    """Fetch all PL/pgSQL procedures from the database."""
    with connection.cursor() as cur:
        cur.execute(DUMP_SQL)
        columns = [desc[0] for desc in cur.description]
        return [_parse_row(dict(zip(columns, row))) for row in cur.fetchall()]


def cache_source(proc: ProcedureDef, cache_dir: Path) -> Path:
    """Write original source to cache for later restoration."""
    proc_dir = cache_dir / proc.oid
    proc_dir.mkdir(parents=True, exist_ok=True)

    source_path = proc_dir / "source.sql"
    source_path.write_text(proc.source)

    meta_path = proc_dir / "meta.json"
    meta_path.write_text(json.dumps({
        "oid": proc.oid,
        "schema": proc.schema,
        "name": proc.name,
        "return_type": proc.return_type,
        "volatility": proc.volatility,
        "is_strict": proc.is_strict,
        "is_secdef": proc.is_secdef,
        "is_setof": proc.is_setof,
        "arg_modes": proc.arg_modes,
        "arg_names": proc.arg_names,
        "arg_types": proc.arg_types,
    }, indent=2))

    return source_path


def load_cached_source(oid: str, cache_dir: Path) -> str | None:
    """Read original source from cache."""
    source_path = cache_dir / oid / "source.sql"
    if source_path.exists():
        return source_path.read_text()
    return None


def load_cached_meta(oid: str, cache_dir: Path) -> dict | None:
    """Read cached metadata."""
    meta_path = cache_dir / oid / "meta.json"
    if meta_path.exists():
        return json.loads(meta_path.read_text())
    return None
