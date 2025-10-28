import os
import shutil
import pickle
from typing import Dict, Any

class CacheDir:
    """
    A file-system based cache manager. Works like a Hash/dict, where each key
    corresponds to a separate file in the cache directory. Supports lazy loading
    and simple data serialization (using pickle).

    This is a Python translation of Piggly::Compiler::CacheDir.
    """

    # We skip the complex Ruby Marshal HINT check. In Python, we simply try/except
    # pickle.load. If it fails, we assume the content is raw text.

    def __init__(self, directory: str):
        self.dir = directory
        # @data is the in-memory cache, loaded lazily via __getitem__
        self._data: Dict[str, Any] = {}

    def _load_from_disk(self, key: str) -> Any:
        """Loads data from the file system into memory for a given key."""
        path = os.path.join(self.dir, key)
        
        if not os.path.exists(path):
            return None

        # Attempt to read as pickled data (serialized object)
        try:
            with open(path, "rb") as f:
                return pickle.load(f)
        except (pickle.UnpicklingError, EOFError):
            # If unpickling fails, assume it's raw text data
            try:
                with open(path, "r", encoding='utf-8') as f:
                    return f.read()
            except UnicodeDecodeError:
                # If reading as text fails, fall back to reading as raw bytes
                with open(path, "rb") as f:
                    return f.read()
        except FileNotFoundError:
             # Should be caught by os.path.exists, but kept for robustness
             return None

    def __getitem__(self, key: str) -> Any:
        """
        Retrieves an item from the in-memory cache, loading it from disk if needed.
        Equivalent to Ruby's Hash default block logic.
        """
        key_str = str(key)
        if key_str not in self._data:
            # If not in memory, try loading from disk
            value = self._load_from_disk(key_str)
            if value is not None:
                self._data[key_str] = value
        
        return self._data.get(key_str)

    def __setitem__(self, key: str, value: Any):
        """
        Writes through to the file system immediately.
        """
        key_str = str(key)
        self._data[key_str] = value
        self._write({key_str: value})

    def update(self, data: Dict[Any, Any]):
        """
        Writes through to file system for all items in the hash.
        Equivalent to Ruby's #update.
        """
        for k, v in data.items():
            self[k] = v
        return self

    def delete(self, key: str):
        """
        Deletes the key from memory and the corresponding file from disk.
        """
        key_str = str(key)
        path = os.path.join(self.dir, key_str)
        if os.path.exists(path):
            os.unlink(path)
        self._data.pop(key_str, None)

    def keys(self) -> list[str]:
        """
        Returns a list of all cached keys (file names) on disk.
        """
        if os.path.exists(self.dir):
            return os.listdir(self.dir)
        return []

    def clear(self):
        """
        Clears memory, destroys contents on disk, and creates the directory.
        """
        self._data.clear()

        if os.path.exists(self.dir):
            # Recursively remove directory contents (Ruby's FileUtils.rm(Dir["#{@dir}/*"]))
            for filename in os.listdir(self.dir):
                filepath = os.path.join(self.dir, filename)
                try:
                    if os.path.isfile(filepath) or os.path.islink(filepath):
                        os.unlink(filepath)
                    elif os.path.isdir(filepath):
                        shutil.rmtree(filepath)
                except Exception as e:
                    print(f"Failed to delete {filepath}. Reason: {e}")
            
            # Update mtime (Ruby's FileUtils.touch(@dir))
            os.utime(self.dir, None)
        else:
            os.makedirs(self.dir)

        return self

    def replace(self, data: Dict[Any, Any]):
        """
        Clears entire cache, replaces contents, and returns self.
        """
        self.clear()
        self.update(data)
        return self

    def _write(self, data: Dict[str, Any]):
        """
        Serializes each entry to disk.
        """
        os.makedirs(self.dir, exist_ok=True)
        os.utime(self.dir, None) # Update mtime

        for key, value in data.items():
            path = os.path.join(self.dir, key)
            
            # Use 'w' for simple strings, 'wb' for everything else (pickling)
            if isinstance(value, str):
                # Write raw string content (Ruby's direct write)
                with open(path, "w", encoding='utf-8') as f:
                    f.write(value)
            else:
                # Pickle (Ruby's Marshal.dump)
                with open(path, "wb") as f:
                    pickle.dump(value, f)

    # Alias to standard Python dict methods
    def __contains__(self, key):
        return str(key) in self._data or os.path.exists(os.path.join(self.dir, str(key)))

    def get(self, key, default=None):
        value = self[key]
        return value if value is not None else default