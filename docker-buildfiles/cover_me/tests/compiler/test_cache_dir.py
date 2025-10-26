import pytest
import os
import shutil
import pickle
from collections import namedtuple
from pathlib import Path

# Assuming you place the CacheDir class in src/compiler/cache_dir.py
# You would need to update your imports based on your final project structure.
from src.compiler.cache_dir import CacheDir # <-- ADJUST THIS IMPORT PATH

# Define a temporary directory for testing
TEST_CACHE_DIR = Path("temp_piggly_cache")

# --- Fixtures for Setup/Teardown ---

@pytest.fixture(scope="module", autouse=True)
def setup_teardown():
    """Ensure the test directory is created before the module tests run, and cleaned up after."""
    if TEST_CACHE_DIR.exists():
        shutil.rmtree(TEST_CACHE_DIR)
    TEST_CACHE_DIR.mkdir()
    yield # Run tests
    if TEST_CACHE_DIR.exists():
        shutil.rmtree(TEST_CACHE_DIR)

@pytest.fixture
def cache_dir_instance():
    """Provides a fresh CacheDir instance for each test function."""
    # Ensure the directory is clean before each test
    if TEST_CACHE_DIR.exists():
        for item in TEST_CACHE_DIR.iterdir():
            if item.is_file():
                item.unlink()
    return CacheDir(str(TEST_CACHE_DIR))

# --- Custom Class for Pickling Test ---
# Use a simple class to ensure pickle/unpickle is working correctly

# RENAMED to fix PytestCollectionWarning and NameError
CacheTestObject = namedtuple("CacheTestObject", ["name", "value"])

# --- Test Cases ---

def test_initialization(cache_dir_instance):
    """Test that the cache directory path is set correctly."""
    assert cache_dir_instance.dir == str(TEST_CACHE_DIR)
    assert os.path.exists(TEST_CACHE_DIR)

def test_write_and_read_string(cache_dir_instance):
    """Test writing and reading raw string data."""
    key = "code"
    value = "SELECT * FROM users;"
    
    # Write
    cache_dir_instance[key] = value
    
    # Verify file exists and content is correct
    file_path = TEST_CACHE_DIR / key
    assert file_path.exists()
    assert file_path.read_text(encoding='utf-8') == value

    # Read (checks load-from-disk logic)
    # Clear in-memory cache to force disk read
    cache_dir_instance._data = {} 
    read_value = cache_dir_instance[key]
    assert read_value == value

def test_write_and_read_object(cache_dir_instance):
    """Test writing and reading a complex object using pickle."""
    key = "tags"
    # UPDATED NAME HERE
    value = CacheTestObject("tag_list", [1, 2, 3])

    # Write
    cache_dir_instance[key] = value
    
    # Verify file exists
    file_path = TEST_CACHE_DIR / key
    assert file_path.exists()
    
    # Manually verify it's pickled data (not raw string)
    with open(file_path, 'rb') as f:
        loaded_raw = pickle.load(f)
    assert loaded_raw == value
    
    # Read (checks load-from-disk logic)
    cache_dir_instance._data = {}
    read_value = cache_dir_instance[key]
    assert read_value == value
    # UPDATED NAME HERE
    assert isinstance(read_value, CacheTestObject)

def test_delete(cache_dir_instance):
    """Test deleting a cached item."""
    key = "to_delete"
    cache_dir_instance[key] = "ephemeral"
    file_path = TEST_CACHE_DIR / key
    assert file_path.exists()
    
    # Delete
    cache_dir_instance.delete(key)
    
    # Verify deletion from disk and memory
    assert not file_path.exists()
    assert key not in cache_dir_instance._data

def test_keys(cache_dir_instance):
    """Test retrieving list of keys on disk."""
    cache_dir_instance["a"] = 1
    cache_dir_instance["b"] = 2
    
    keys = cache_dir_instance.keys()
    # Keys should match file names
    assert sorted(keys) == ["a", "b"]

def test_clear_and_replace(cache_dir_instance):
    """Test clear() and replace() methods."""
    cache_dir_instance["old"] = "data"
    
    # Test clear
    cache_dir_instance.clear()
    assert not cache_dir_instance.keys() # Directory should be empty

    # Test replace
    new_data = {"tree": "root", "code": "def func:"}
    cache_dir_instance.replace(new_data)
    
    assert sorted(cache_dir_instance.keys()) == ["code", "tree"]
    assert cache_dir_instance.get("tree") == "root"

def test_lazy_loading(cache_dir_instance):
    """Test that items only load when accessed."""
    key = "lazy_item"
    cache_dir_instance[key] = "test"
    
    # Data is in memory immediately after write
    assert key in cache_dir_instance._data

    # Clear memory
    cache_dir_instance._data = {}
    assert key not in cache_dir_instance._data
    
    # Access forces load
    assert cache_dir_instance[key] == "test"
    assert key in cache_dir_instance._data