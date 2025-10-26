import sys
from typing import Any, List, Dict
# Assuming the Python equivalents for these classes exist
from .compiler.trace_compiler import TraceCompiler

class ParserFailure(RuntimeError):
    """Placeholder for Piggly::Parser::Failure, used in rescue block."""
    pass

class Installer:
    """
    Handles installing and uninstalling procedures in the database, 
    including necessary instrumentation support functions.
    (Translation of Piggly::Installer)
    """

    def __init__(self, config: Any, connection: Any):
        self.config = config
        self.connection = connection

    def install(self, procedures: List[Any], profile: Any):
        """
        Installs the traced procedures, wrapped in a database transaction 
       .
        """
        try:
            self.connection.exec("BEGIN")

            self._install_support(profile)

            for p in procedures:
                try:
                    self._trace(p, profile)
                except ParserFailure:
                    print(sys.exc_info()[1]) # Prints the exception message
            
            self.connection.exec("COMMIT")
        except Exception:
            self.connection.exec("ROLLBACK")
            raise

    def uninstall(self, procedures: List[Any]):
        """
        Restores the original procedures (untrace) and uninstalls support functions 
       .
        """
        try:
            self.connection.exec("BEGIN")

            for p in procedures:
                self._untrace(p)
                
            self._uninstall_support()

            self.connection.exec("COMMIT")
        except Exception:
            self.connection.exec("ROLLBACK")
            raise

    def _trace(self, procedure: Any, profile: Any):
        """
        Recompiles with instrumentation, runs the compiler, and installs the 
        instrumented code in the database.
        """
        try:
            # recompile with instrumentation
            compiler = TraceCompiler(self.config)
            result = compiler.compile(procedure)
            # result keys: :tree, :tags, :code
            
            # Install the instrumented code (result[:code])
            # Assumes procedure.definition(code) returns the full CREATE OR REPLACE string
            self.connection.exec(procedure.definition(result["code"]))
            
            profile.add(procedure, result["tags"], result)
        except Exception as e:
            # Concatenate error message as done in Ruby
            msg = getattr(e, 'message', str(e))
            msg += f"\nError installing traced procedure {procedure.name} "
            msg += f"from {procedure.source_path(self.config)}"
            # Re-raise the exception with the modified message
            raise type(e)(msg) from e 

    def _untrace(self, procedure: Any):
        """
        Restores the original procedure source code from the cache to the database 
       .
        """
        # Assumes procedure.definition(source) returns the full CREATE OR REPLACE string
        self.connection.exec(procedure.definition(procedure.source(self.config)))

    def _install_support(self, profile: Any):
        """
        Installs necessary instrumentation support functions (coverage_*) into the database 
       .
        """
        # Set notice processor (equivalent of @connection.set_notice_processor)
        # Assumed method: self.connection.set_notice_processor(profile.notice_processor(self.config))

        trace_prefix = self.config.trace_prefix # Assumed config value

        # coverage_cond function
        self.connection.exec(f"""
            -- Signals that a conditional expression was executed
            CREATE OR REPLACE FUNCTION coverage_cond(message varchar, value boolean)
              RETURNS boolean AS $$
            BEGIN
              IF value THEN
                RAISE WARNING '{trace_prefix} % t', message;
              ELSE
                RAISE WARNING '{trace_prefix} % f', message;
              END IF;
              RETURN value;
            END $$ LANGUAGE 'plpgsql' VOLATILE;
        """)

        # coverage_signal function
        self.connection.exec(f"""
            -- Generic signal
            CREATE OR REPLACE FUNCTION coverage_signal(message varchar, signal varchar)
              RETURNS void AS $$
            BEGIN
              RAISE WARNING '{trace_prefix} % %', message, signal;
            END $$ LANGUAGE 'plpgsql' VOLATILE;
        """)

        # coverage_expr (varchar) function
        self.connection.exec(f"""
            -- Signals that a (sub)expression was executed. handles '' and NULL value
            CREATE OR REPLACE FUNCTION coverage_expr(message varchar, value varchar)
              RETURNS varchar AS $$
            BEGIN
              RAISE WARNING '{trace_prefix} %', message;
              RETURN value;
            END $$ LANGUAGE 'plpgsql' VOLATILE;
        """)

        # coverage_expr (anyelement) function
        self.connection.exec(f"""
            -- Signals that a (sub)expression was executed. handles all other types
            CREATE OR REPLACE FUNCTION coverage_expr(message varchar, value anyelement)
              RETURNS anyelement AS $$
            BEGIN
              RAISE WARNING '{trace_prefix} %', message;
              RETURN value;
            END $$ LANGUAGE 'plpgsql' VOLATILE;
        """)

        # coverage_branch function
        self.connection.exec(f"""
            -- Signals that a branch was taken
            CREATE OR REPLACE FUNCTION coverage_branch(message varchar)
              RETURNS void AS $$
            BEGIN
              RAISE WARNING '{trace_prefix} %', message;
            END $$ LANGUAGE 'plpgsql' VOLATILE;
        """)

    def _uninstall_support(self):
        """
        Uninstalls instrumentation support functions.
        """
        # Restore default notice processor (assumed method)
        # self.connection.set_notice_processor(lambda x: sys.stderr.write(x)) 
        
        # Drop tracing functions
        self.connection.exec("DROP FUNCTION IF EXISTS coverage_cond(varchar, boolean)")
        self.connection.exec("DROP FUNCTION IF EXISTS coverage_expr(varchar, varchar)")
        self.connection.exec("DROP FUNCTION IF EXISTS coverage_expr(varchar, anyelement)")
        self.connection.exec("DROP FUNCTION IF EXISTS coverage_branch(varchar)")
        self.connection.exec("DROP FUNCTION IF EXISTS coverage_signal(varchar, varchar)")