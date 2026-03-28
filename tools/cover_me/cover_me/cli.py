"""
CLI entry point for cover_me.

Commands:
    trace   — dump, instrument, and install functions
    report  — parse trace and generate opencover.xml
    untrace — restore original functions from cache
"""
import argparse
import sys
from pathlib import Path

from cover_me.instrumenter import instrument
from cover_me.profile import Profile
from cover_me.reporter import generate_opencover
from cover_me.html_reporter import generate_html


DEFAULT_CACHE_DIR = Path("/coverage/cache")
DEFAULT_OUTPUT_DIR = Path("/coverage")


def _connect_pg(args):
    import psycopg2
    return psycopg2.connect(
        host=args.host, port=args.port, dbname=args.dbname,
        user=args.user, password=args.password,
    )


def _connect_mysql(args):
    import mysql.connector
    return mysql.connector.connect(
        host=args.host, port=args.port, database=args.dbname,
        user=args.user, password=args.password,
    )


def _get_engine_modules(engine: str):
    if engine == "mysql":
        from cover_me.mysql import dump_procedures
        from cover_me.mysql.installer import (
            install_helpers, uninstall_helpers,
            install_instrumented, restore_original,
            cache_create_sql,
        )
        from cover_me.mysql.profile import parse_trace_table
        from cover_me.models import cache_source, load_cached_source
        return {
            "dump": dump_procedures,
            "install_helpers": install_helpers,
            "uninstall_helpers": uninstall_helpers,
            "install_instrumented": install_instrumented,
            "restore_original": restore_original,
            "cache_source": cache_source,
            "load_cached_source": load_cached_source,
            "cache_create_sql": cache_create_sql,
            "parse_trace_table": parse_trace_table,
        }
    else:
        from cover_me.pg.dumper import dump_procedures
        from cover_me.pg.installer import (
            install_helpers, uninstall_helpers,
            install_instrumented, restore_original,
        )
        from cover_me.models import cache_source, load_cached_source
        return {
            "dump": dump_procedures,
            "install_helpers": install_helpers,
            "uninstall_helpers": uninstall_helpers,
            "install_instrumented": install_instrumented,
            "restore_original": restore_original,
            "cache_source": cache_source,
            "load_cached_source": load_cached_source,
            "cache_create_sql": None,
            "parse_trace_table": None,
        }


def _add_db_args(parser: argparse.ArgumentParser) -> None:
    parser.add_argument("-E", "--engine", choices=["postgres", "mysql"], default="postgres")
    parser.add_argument("-H", "--host", default="localhost")
    parser.add_argument("-p", "--port", type=int, default=None)
    parser.add_argument("-d", "--dbname", required=True)
    parser.add_argument("-U", "--user", default="root")
    parser.add_argument("-W", "--password", default="")
    parser.add_argument("-c", "--cache-dir", type=Path, default=DEFAULT_CACHE_DIR)


def _connect(args):
    if args.port is None:
        args.port = 3306 if args.engine == "mysql" else 5432
    if args.engine == "mysql":
        return _connect_mysql(args)
    return _connect_pg(args)


def cmd_trace(args) -> None:
    """Dump functions, instrument them, install helpers and instrumented versions."""
    engine = args.engine
    mod = _get_engine_modules(engine)
    conn = _connect(args)
    cache_dir = args.cache_dir
    cache_dir.mkdir(parents=True, exist_ok=True)

    procedures = mod["dump"](conn)
    if not procedures:
        print("No stored procedures/functions found.", file=sys.stderr)
        conn.close()
        return

    print(f"Found {len(procedures)} functions")

    for proc in procedures:
        mod["cache_source"](proc, cache_dir)
        if engine == "mysql" and mod["cache_create_sql"]:
            mod["cache_create_sql"](conn, proc, cache_dir)

    mod["install_helpers"](conn)
    print("Installed helper functions")

    count = 0
    for proc in procedures:
        result = instrument(proc.source, proc.oid, engine=engine)
        mod["install_instrumented"](conn, proc, result.source)
        print(f"  Traced {proc.qualified_name} ({len(result.tags)} tags)")
        count += 1

    print(f"Instrumented {count} functions")
    conn.close()


def cmd_untrace(args) -> None:
    """Restore original functions from cache and remove helpers."""
    mod = _get_engine_modules(args.engine)
    conn = _connect(args)
    cache_dir = args.cache_dir

    if not cache_dir.exists():
        print("No cache directory found.", file=sys.stderr)
        conn.close()
        return

    count = 0
    for oid_dir in sorted(cache_dir.iterdir()):
        if oid_dir.is_dir():
            if mod["restore_original"](conn, oid_dir.name, cache_dir):
                print(f"  Restored OID {oid_dir.name}")
                count += 1

    mod["uninstall_helpers"](conn)
    print(f"Restored {count} functions, removed helpers")
    conn.close()


def cmd_report(args) -> None:
    """Parse trace and generate OpenCover XML."""
    engine = args.engine
    mod = _get_engine_modules(engine)
    conn = _connect(args)
    cache_dir = args.cache_dir

    procedures = mod["dump"](conn)
    if not procedures:
        print("No stored procedures/functions found.", file=sys.stderr)
        conn.close()
        return

    profile = Profile()
    tags_by_oid: dict[str, list] = {}
    for proc in procedures:
        cached_source = mod["load_cached_source"](proc.oid, cache_dir)
        source = cached_source if cached_source else proc.source
        result = instrument(source, proc.oid, engine=engine)
        tags_by_oid[proc.oid] = result.tags
        profile.register(result.tags)

    # Parse trace — file for postgres, table for mysql
    if engine == "mysql" and mod["parse_trace_table"]:
        hits = mod["parse_trace_table"](conn, profile)
        print(f"Parsed {hits} coverage hits from trace table")
    else:
        hits = profile.parse_file(args.file)
        print(f"Parsed {hits} coverage hits from {args.file}")

    # Export source files
    source_dir = args.output.parent / "source"
    for proc in procedures:
        cached_source = mod["load_cached_source"](proc.oid, cache_dir)
        source = cached_source if cached_source else proc.source
        out_dir = source_dir / proc.schema
        out_dir.mkdir(parents=True, exist_ok=True)
        (out_dir / f"{proc.name}.sql").write_text(source)
    print(f"Exported source to {source_dir}")

    generate_opencover(procedures, tags_by_oid, profile, args.output, source_dir)
    print(f"Generated {args.output}")

    html_dir = args.output.parent / "html"
    generate_html(args.output, html_dir)
    conn.close()


def main(argv: list[str] | None = None) -> None:
    parser = argparse.ArgumentParser(prog="cover_me", description="Database code coverage tool")
    sub = parser.add_subparsers(dest="command", required=True)

    p_trace = sub.add_parser("trace", help="Instrument functions for coverage")
    _add_db_args(p_trace)

    p_untrace = sub.add_parser("untrace", help="Restore original functions")
    _add_db_args(p_untrace)

    p_report = sub.add_parser("report", help="Generate OpenCover XML from trace")
    p_report.add_argument("-f", "--file", type=Path, default=None, help="Trace file (postgres only)")
    p_report.add_argument("-o", "--output", type=Path, default=DEFAULT_OUTPUT_DIR / "opencover.xml")
    _add_db_args(p_report)

    args = parser.parse_args(argv)

    if args.command == "trace":
        cmd_trace(args)
    elif args.command == "untrace":
        cmd_untrace(args)
    elif args.command == "report":
        cmd_report(args)


if __name__ == "__main__":
    main()
