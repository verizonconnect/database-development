import os
import sys
import re
import yaml
import json
import io
from typing import List, Tuple, Any, Callable, Dict, Set

# Placeholder modules needed for the logic (must be installed via requirements.txt)
import psycopg2 # Ruby's PGconn equivalent
from ..config import Config # Assumed to exist
from ..dumper.reified_procedure import SkeletonProcedure

class BaseCommand:
    """
    Base class for all piggly commands, providing core utilities for 
    connection, procedure filtering, and option handling.
    """

    # --- Command Dispatch ---

    @staticmethod
    def main(argv: List[str]):
        """
        Dispatches the command based on argv[0].
        (Translates Ruby's Base.main)
        """
        cmd_class, args = BaseCommand.command(argv)

        if cmd_class is None:
            # Ruby: abort "usage: #{$0} {report|trace|untrace} --help"
            sys.exit(f"usage: {sys.argv[0]} {{report|trace|untrace}} --help")
        else:
            # Python standard practice uses an execute method on the class/instance
            cmd_class.execute(args) # Assumed execution method

    @staticmethod
    def command(argv: List[str]) -> Tuple[Any, List[str]]:
        """
        Parses argv[0] to determine the command class.
        (Translates Ruby's Base.command)
        """
        if not argv:
            return None, []

        head, *tail = argv
        
        # NOTE: ReportCommand, TraceCommand, and UntraceCommand must be imported 
        # or defined locally to replace Ruby's dynamic case/when lookup.
        # Placeholder names are used here based on the Ruby file names.
        
        # We assume sibling modules/classes named ReportCommand, TraceCommand, etc.
        #if head.lower() == "report":
        #    return ReportCommand, tail # Assumed command class
        if head.lower() == "trace":
            from .trace import TraceCommand
            return TraceCommand, tail # Assumed command class
        #if head.lower() == "untrace":
        #    return UntraceCommand, tail # Assumed command class
            
        return None, argv

    # --- Database Connection ---

    @staticmethod
    def connect(config: Any) -> Any: # Replace 'Any' with 'psycopg2.connection'
        """
        Connects to PostgreSQL using configuration from a YAML/JSON file.
        (Translates Ruby's Base.connect)
        """
        # Ruby config paths:
        files = [
            getattr(config, 'database_yml', None),
            'config/database.yml', 'config/database.json'
        ]
        
        # Remove None values and find the first existing path
        path = next((f for f in files if f and os.path.exists(f)), None)
        
        if not path:
            # Ruby: raise "No database config files found: #{files.join(", ")}"
            raise RuntimeError(f"No database config files found: {', '.join(f for f in files if f)}")

        # --- Load and Parse Config File ---
        with open(path, 'r') as f:
            raw_content = f.read()
            
        # Ruby uses ERB for templating, Python uses simple str.format or jinja2. 
        # Assuming no templating for simplicity, loading raw content.
        
        ext = os.path.splitext(path)[1].lower()

        if ext == ".json":
            specs = json.loads(raw_content)
        else:
            # Fallback to YAML (handles .yml and default assumption)
            specs = yaml.safe_load(raw_content)

        # --- Select Connection Spec ---
        conn_name = getattr(config, 'connection_name', 'default') # Assumed default 'default'
        
        if isinstance(specs, dict) and conn_name in specs:
            spec = specs[conn_name]
        else:
            # Ruby: raise "Database '#{config.connection_name}' is not configured in #{path}"
            raise RuntimeError(f"Database '{conn_name}' is not configured in {path}")

        print(f"Connecting to database using spec '{conn_name}'...")
        try:
            # Map Ruby's spec keys to standard psycopg2 connection parameters
            connection = psycopg2.connect(
                host=spec.get("host"), 
                port=spec.get("port"),
                dbname=spec.get("database"), # Use dbname for consistency
                user=spec.get("username"), 
                password=spec.get("password")
            )
            print(f"Successfully connected to the database. {spec.get('database')}")
            return connection
        except psycopg2.Error as e:
            # Catch connection errors and re-raise as a generic RuntimeError
            raise RuntimeError(f"Failed to connect to database '{conn_name}': {e}") from e
        
        print(f"Successfully loaded database spec for '{conn_name}'.")
        return spec # Returning spec dictionary as a placeholder

    # --- Procedure Filtering ---

    @staticmethod
    def filter(config: Any, index: Any) -> List[Any]: # Replace 'Any' with actual types
        """
        Applies include (+) and reject (-) filters to the list of procedures.
        (Translates Ruby's Base.filter using Python set operations)
        """
        filters = getattr(config, 'filters', [])
        
        #all_procedures = getattr(index, 'procedures', [])
        all_procedures = index.procedures()
        
        if not filters:
            return all_procedures
        else:
            # Filters are pairs: [(:+ or :-), filter_func]
            
            # 1. Determine initial set based on the first filter type
            head_op, head_func = filters[0]
            if head_op == '+':
                result_set = set()
            elif head_op == '-':
                result_set = set(all_procedures)
            else:
                result_set = set()

            # 2. Apply subsequent filters using set algebra
            for op, filter_func in filters:
                # Find all procedures matching the current filter function
                match_set = {p for p in all_procedures if filter_func(p)}

                if op == '+':
                    # Union operation (inclusion)
                    result_set.update(match_set)
                elif op == '-':
                    # Difference operation (exclusion/rejection)
                    result_set.difference_update(match_set)
            
            # Return the result as a list (order is lost, matching Ruby's general behavior)
            return list(result_set)

    # --- Option Handlers (Must return a function/lambda to set config values) ---

    @staticmethod
    def o_accumulate(config: Any) -> Callable:
        """Handler for --accumulate."""
        return lambda x: setattr(config, 'accumulate', x)

    @staticmethod
    def o_cache_root(config: Any) -> Callable:
        """Handler for --cache-root PATH."""
        return lambda x: setattr(config, 'cache_root', x)

    @staticmethod
    def o_report_root(config: Any) -> Callable:
        """Handler for --report-root PATH."""
        return lambda x: setattr(config, 'report_root', x)

    @staticmethod
    def o_include_paths(config: Any) -> Callable:
        """Handler for --include-paths PATH:PATH."""
        return lambda x: config.include_paths.extend(x.split(":"))

    @staticmethod
    def o_database_yml(config: Any) -> Callable:
        """Handler for --database PATH."""
        return lambda x: setattr(config, 'database_yml', x)

    @staticmethod
    def o_connection_name(config: Any) -> Callable:
        """Handler for --connection NAME."""
        return lambda x: setattr(config, 'connection_name', x)

    @staticmethod
    def o_version(config: Any) -> Callable:
        """Handler for --version."""
        # Requires PIGGLY_VERSION to be defined globally/in config
        return lambda x: (print(f"piggly {config.VERSION} {config.RELEASE_DATE}"), sys.exit(0))
    
    @staticmethod
    def o_dry_run(config: Any) -> Callable:
        """Handler for --dry-run."""
        return lambda x: setattr(config, 'dry_run', True)

    @staticmethod
    def o_select(config: Any) -> Callable:
        """Handler for --select PATTERN (inclusion filter)."""
        def handler(x: str):
            if m := re.match(r'^/([^/]+)/$', x):
                # Regex match filter
                filter_func = lambda p: re.search(m.group(1), p.name) # Assumes p.name is a string/searchable
            else:
                # Exact string match filter
                filter_func = lambda p: str(p.name) == x

            config.filters.append(('+', filter_func))
        return handler

    @staticmethod
    def o_reject(config: Any) -> Callable:
        """Handler for --reject PATTERN (exclusion filter)."""
        def handler(x: str):
            if m := re.match(r'^/([^/]+)/$', x):
                # Regex match filter
                filter_func = lambda p: re.search(m.group(1), p.name)
            else:
                # Exact string match filter
                filter_func = lambda p: str(p.name) == x

            config.filters.append(('-', filter_func))
        return handler