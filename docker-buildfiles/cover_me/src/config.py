import os
import re
import shutil
from typing import List, Any

# --- Static Methods (Ruby: class << Config) ---

class ConfigUtils:
    """Static utility methods for path manipulation (Ruby's class << Config)."""

    @staticmethod
    def path(root: str, file: str = None) -> str:
        """
        Calculates the full path, respecting absolute/relative markers.
        """
        if file is None:
            return root

        # Ruby checks for: starts with '..', starts with '/', or starts with 'D:' (Windows drive letter)
        # Python regex checks: starts with .., starts with /, or starts with [A-Z]:\ or [A-Z]:/
        is_absolute_or_explicit_relative = re.match(r'^\.\.|^/|^[A-Z]:[\\/]', file, re.I)
        
        if is_absolute_or_explicit_relative:
            # If it's already absolute or explicitly relative (../), return it
            return file
        else:
            # Otherwise, join relative to the provided root
            return os.path.join(root, file)

    @staticmethod
    def mkpath(root: str, file: str = None) -> str:
        """
        Ensures the directory path exists and returns the final path.
        (Replaces Ruby's FileUtils.makedirs)
        """
        if file is None:
            # Create directory if it doesn't exist
            os.makedirs(root, exist_ok=True)
            return root
        else:
            # 1. Calculate the final path
            final_path = ConfigUtils.path(root, file)
            
            # 2. Get the directory name and create it
            dir_name = os.path.dirname(final_path)
            os.makedirs(dir_name, exist_ok=True)
            
            # 3. Return the final file path
            return final_path

# --- Instance Class (Ruby: class Config) ---

class Config:
    """
    Configuration object for piggly commands, holding paths, flags, and filters.
    (Translation of Piggly::Config)
    """

    def __init__(self):
        # Set instance variables with expanded defaults
        # Ruby: File.expand_path("#{Dir.pwd}/piggly/cache")
        self._cache_root: str = os.path.abspath(os.path.join(os.getcwd(), 'cover_me', 'cache')) 
        
        # Ruby: File.expand_path("#{Dir.pwd}/piggly/reports")
        self._report_root: str = os.path.abspath(os.path.join(os.getcwd(), 'cover_me', 'reports')) 
        
        # Other defaults
        self._database_yml: str = None
        self._connection_name: str = "cover_me"
        self._trace_prefix: str = "COVER"
        self._accumulate: bool = False
        self._dry_run: bool = False
        self._filters: List[Any] = []

    # --- Properties (Ruby: attr_accessor and aliases) ---
    
    # 1. cache_root
    @property
    def cache_root(self) -> str:
        return self._cache_root
    @cache_root.setter
    def cache_root(self, value: str):
        self._cache_root = value

    # 2. report_root
    @property
    def report_root(self) -> str:
        return self._report_root
    @report_root.setter
    def report_root(self, value: str):
        self._report_root = value
        
    # 3. database_yml
    @property
    def database_yml(self) -> str:
        return self._database_yml
    @database_yml.setter
    def database_yml(self, value: str):
        self._database_yml = value
        
    # 4. connection_name
    @property
    def connection_name(self) -> str:
        return self._connection_name
    @connection_name.setter
    def connection_name(self, value: str):
        self._connection_name = value
        
    # 5. trace_prefix
    @property
    def trace_prefix(self) -> str:
        return self._trace_prefix
    @trace_prefix.setter
    def trace_prefix(self, value: str):
        self._trace_prefix = value
        
    # 6. accumulate (and accumulate?)
    @property
    def accumulate(self) -> bool:
        return self._accumulate
    @accumulate.setter
    def accumulate(self, value: bool):
        self._accumulate = value
    accumulate_ = accumulate # Alias for Ruby's accumulate?

    # 7. dry_run (and dry_run?)
    @property
    def dry_run(self) -> bool:
        return self._dry_run
    @dry_run.setter
    def dry_run(self, value: bool):
        self._dry_run = value
    dry_run_ = dry_run # Alias for Ruby's dry_run?

    # 8. filters
    @property
    def filters(self) -> List[Any]:
        return self._filters
    @filters.setter
    def filters(self, value: List[Any]):
        self._filters = value

    # --- Path Helpers referencing static methods ---
    
    def path(self, *args) -> str:
        """Instance method calling the static path helper."""
        return ConfigUtils.path(*args)

    def mkpath(self, *args) -> str:
        """Instance method calling the static mkpath helper."""
        return ConfigUtils.mkpath(*args)