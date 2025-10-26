import os
import re
from typing import Any, List, Tuple, Dict, Callable

import psycopg2.extras

# --- Dependency Placeholders (Assumed to be defined elsewhere in dumper/util) ---

class QualifiedName:
    def __init__(self, schema: str, name: str):
        self.schema = schema
        self.name = name

class QualifiedType:
    @staticmethod
    def parse(type_str: str, schema: str = None) -> Any: pass # Placeholder

class RecordType:
    def __init__(self, *args): pass # Placeholder

class SkeletonProcedure:
    """Base class for ReifiedProcedure."""
    def __init__(self, oid, name, strict, secdef, setof, type, volatility, arg_modes, arg_names, arg_types, arg_defaults):
        self.oid = oid
        self.name = name
        self.strict = strict
        self.secdef = secdef
        self.setof = setof
        self.type = type
        self.volatility = volatility
        self.arg_modes = arg_modes
        self.arg_names = arg_names
        self.arg_types = arg_types
        self.arg_defaults = arg_defaults
    
    def purge_source(self, config: Any): pass # Placeholder
    
    def source_path(self, config: Any) -> str:
        # Assumed config object has method to compute source file path
        return os.path.join(config.cache_root, 'dumper', f"{self.oid}.sql")

    def identifier(self) -> str: # Placeholder for index key
        return f"{self.oid}"

class ReifiedProcedure(SkeletonProcedure):
    """
    Procedure source code is stored as an instance variable.
    (Translation of Piggly::Dumper::ReifiedProcedure)
    """

    def __init__(self, source: str, oid: str, name: QualifiedName, strict: bool, secdef: bool, setof: bool, type: Any, volatility: str, arg_modes: List[str], arg_names: List[QualifiedName], arg_types: List[QualifiedType], arg_defaults: List[str]):
        
        #
        self._source = source.strip()

        # Handle RECORD type output arguments (Ruby's 't' mode)
        # Python equivalent of Ruby's String#include? is 'in'
        if type and type.name == "record" and type.schema == "pg_catalog" and "t" in arg_modes:
            prefix = 0
            for i, mode in enumerate(arg_modes):
                if mode == "t":
                    prefix = i
                    break
            
            type = RecordType(arg_types[prefix:], arg_names[prefix:], arg_modes[prefix:], arg_defaults[prefix:])
            arg_modes = arg_modes[0:prefix]
            arg_types = arg_types[0:prefix]
            arg_names = arg_names[0:prefix]
            arg_defaults = arg_defaults[0:prefix]
            setof = False

        super().__init__(oid, name, strict, secdef, setof, type, volatility, arg_modes, arg_names, arg_types, arg_defaults)

    def source(self, config: Any) -> str:
        """Returns the procedure source code string."""
        return self._source

    def store_source(self, config: Any):
        """Writes the source code to the cache file."""
        if "$COVER$" in self._source:
            raise RuntimeError(
                f"Procedure `{self.name}' is already instrumented. " +
                "This means the original source wasn't restored after the " +
                "last coverage run. You must restore the source manually."
            )

        dir_root = os.path.join(config.cache_root, self.name.schema, self.name.name)
        file_name = f"{self.oid}.sql"

        # The config.mkpath utility handles creating the directory AND returns the final path.
        final_path = config.mkpath(dir_root, file_name)
        
        print(f"final_path: {final_path}")

        # 2. Open and write to the file
        with open(final_path, "wb") as io:
            io.write(self._source.encode('utf-8'))

    def skeleton(self) -> SkeletonProcedure:
        """Returns a SkeletonProcedure equivalent (metadata only)."""
        return SkeletonProcedure(self.oid, self.name, self.strict, self.secdef, self.setof, self.type,
                               self.volatility, self.arg_modes, self.arg_names, self.arg_types,
                               self.arg_defaults)

    def skeleton(self) -> bool:
        """Indicates this is a non-skeleton object."""
        return False

# --- Static Methods ---

class ReifiedProcedureHelpers:
    """Static helpers for ReifiedProcedure (Ruby's class << ReifiedProcedure)"""

    MODES = {
        "i": "in",
        "o": "out",
        "b": "inout",
        "v": "variadic"
    }
    
    # Defaults to returning the key if not found
    MODES_DEFAULT = lambda k: k

    VOLATILITY = {
        "i": "immutable",
        "v": "volatile",
        "s": "stable"
    }
    VOLATILITY_DEFAULT = lambda k: k

    @staticmethod
    def mode(mode: str) -> str:
        """Converts internal PostgreSQL mode (i, o, b, v) to full string."""
        return ReifiedProcedureHelpers.MODES.get(mode, ReifiedProcedureHelpers.MODES_DEFAULT(mode))

    @staticmethod
    def volatility(mode: str) -> str:
        """Converts internal PostgreSQL volatility mode (i, v, s) to full string."""
        return ReifiedProcedureHelpers.VOLATILITY.get(mode, ReifiedProcedureHelpers.VOLATILITY_DEFAULT(mode))

    @staticmethod
    def defaults(exprs: str, count: int, total: int) -> List[str]:
        """Parses default argument expressions."""
        expr_list = exprs.split(", ") if exprs else []

        nreqd = total - count

        if nreqd >= 0 and len(expr_list) == count:
            # Prefix with N None values for non-default arguments
            return [None] * nreqd + expr_list
        else:
            raise RuntimeError("Couldn't parse default arguments")

    @staticmethod
    def all(connection: Any) -> List[ReifiedProcedure]:
        """
        Returns a list of all PL/pgSQL stored procedures in the current database.
        (The SQL query is transcribed here)
        """
        # NOTE: This assumes 'connection' has a 'query' method returning iterable results (e.g., psycopg2 cursor)
        SQL = """
          SELECT
            pro.oid,
            nschema.nspname   AS nschema,
            pro.proname       AS name,
            pro.proisstrict   AS strict,
            pro.prosecdef     AS secdef,
            pro.provolatile   AS volatility,
            pro.proretset     AS setof,
            rschema.nspname   AS tschema,
            ret.typname       AS type,
            pro.prosrc        AS source,
            pro.pronargs      AS arg_count,
            array_to_string(pro.proargmodes, ',') AS arg_modes,
            array_to_string(pro.proargnames, ',') AS arg_names,
            CASE WHEN proallargtypes IS NOT NULL THEN
                   -- use proalltypes array if its non-null
                   array_to_string(array(SELECT format_type(proallargtypes[k], NULL)
                                         FROM generate_series(array_lower(proallargtypes, 1),
                                                              array_upper(proallargtypes, 1)) AS k), ',')
                 ELSE
                   -- fallback to oidvector proargtypes
                   oidvectortypes(pro.proargtypes)
                 END AS arg_types,
            pro.pronargdefaults AS arg_defaults_count,
            COALESCE(pg_get_expr(pro.proargdefaults, 0), '') AS arg_defaults
          FROM pg_proc AS pro,
               pg_type AS ret,
               pg_namespace AS nschema,
               pg_namespace AS rschema
          WHERE pro.pronamespace = nschema.oid
            AND ret.typnamespace = rschema.oid
            AND pro.proname NOT LIKE 'piggly_%'
            AND pro.prorettype = ret.oid
            AND pro.prolang = (SELECT oid FROM pg_language WHERE lanname = 'plpgsql')
            AND pro.pronamespace NOT IN (SELECT oid
                                         FROM pg_namespace
                                         WHERE nspname LIKE 'pg_%'
                                            OR nspname LIKE 'information_schema')
        """
        
        with connection.cursor(cursor_factory=psycopg2.extras.DictCursor) as cursor:
            cursor.execute(SQL)
            results = cursor.fetchall()
            print(f"results, results, results  {results}")
        # Convert fetched DictRow objects to standard dictionaries for from_hash
        return [ReifiedProcedureHelpers.from_hash(dict(x)) for x in results]

    @staticmethod
    def from_hash(hash_data: Dict[str, Any]) -> ReifiedProcedure:
        """Constructs a ReifiedProcedure from a result row (Hash)."""
        
        # Safely convert comma-separated strings/integers to lists/ints, using coalesce helper
        def safe_list(key, default_val):
            val = hash_data.get(key)
            if isinstance(val, str):
                return val.split(',')
            return val if val is not None else default_val

        arg_modes_str = ReifiedProcedureHelpers.coalesce(hash_data.get("arg_modes"), "")
        arg_names_str = ReifiedProcedureHelpers.coalesce(hash_data.get("arg_names"), "")
        arg_types_str = ReifiedProcedureHelpers.coalesce(hash_data.get("arg_types"), "")

        # 1. Base initialization arguments
        source = hash_data["source"]
        oid = hash_data["oid"]
        name = QualifiedName(hash_data["nschema"], hash_data["name"])
        strict = hash_data["strict"] == "t"
        secdef = hash_data["secdef"] == "t"
        setof = hash_data["setof"] == "t"
        type = QualifiedType.parse(hash_data["tschema"], hash_data["type"])
        volatility = ReifiedProcedureHelpers.volatility(hash_data["volatility"])
        
        # 2. Argument list processing
        arg_modes = ReifiedProcedureHelpers.coalesce([ReifiedProcedureHelpers.mode(x.strip()) for x in arg_modes_str.split(',') if x.strip()], 
                                                     ["in"] * int(hash_data["arg_count"]))
        arg_names = [QualifiedName(None, x.strip()) for x in arg_names_str.split(',') if x.strip()]
        arg_types = [QualifiedType.parse(x.strip()) for x in arg_types_str.split(',') if x.strip()]
        
        # 3. Defaults
        arg_defaults = ReifiedProcedureHelpers.defaults(
            hash_data["arg_defaults"],
            int(hash_data["arg_defaults_count"]),
            int(hash_data["arg_count"]))

        return ReifiedProcedure(source, oid, name, strict, secdef, setof, type, volatility,
                                arg_modes, arg_names, arg_types, arg_defaults)

    @staticmethod
    def coalesce(value: Any, default: Any) -> Any:
        """Returns value if not None, empty string, or empty list/tuple; otherwise returns default."""
        if value in [None, "", [], ()]:
            return default
        else:
            return value