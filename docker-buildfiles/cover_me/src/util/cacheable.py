import os
import re
import hashlib
from typing import Any

class CacheableMixin:
    """
    Provides the utility method to calculate a cache path based on the calling
    class name and the source file's path.
    (Translation of Piggly::Util::Cacheable)
    """

    def cache_path(self, file: str) -> str:
        """
        Calculates a unique cache path for a given source file.
        """
        # Assumes self.config is available (@config in Ruby)
        if not hasattr(self, 'config'):
            raise AttributeError("CacheableMixin requires the host class to have a 'config' attribute.")

        # Ruby: classdir = self.class.name[/^(?:.+::)?(.+?)([A-Z][^A-Z]+)?$/, 1]
        class_name = self.__class__.__name__
        match = re.search(r'^(?:.+::)?(.+?)([A-Z][^A-Z]+)?$', class_name)
        classdir = match.group(1) if match else class_name

        # Ruby: full = ::File.expand_path(file)
        full_path = os.path.abspath(file)
        
        # Ruby: hash = Digest::MD5.hexdigest(::File.dirname(full))
        path_hash = hashlib.md5(os.path.dirname(full_path).encode('utf-8')).hexdigest()
        
        # Ruby: base = ::File.basename(file)
        base_name = os.path.basename(file)

        # The Python version uses the standard path components needed for the final call.
        cache_root = getattr(self.config, 'cache_root', '/tmp/cache')
        
        # Ruby's final mkpath call: @config.mkpath(::File.join(@config.cache_root, classdir), base)
        # Assuming config.mkpath behaves like os.path.join for directory construction.
        cache_dir = os.path.join(cache_root, classdir)
        
        # Combine path hash and base name for a unique filename
        filename = f"{path_hash}_{base_name}"
        
        # Return the resulting path (the host method will call mkpath or ensure the directory exists)
        return os.path.join(cache_dir, filename)