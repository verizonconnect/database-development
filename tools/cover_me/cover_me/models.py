"""
Shared data model and cache functions for cover_me.
"""
import json
from dataclasses import dataclass
from pathlib import Path


@dataclass
class ProcedureDef:
    """A stored procedure/function definition."""
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
