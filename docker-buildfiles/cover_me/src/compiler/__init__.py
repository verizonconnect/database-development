from .cache_dir import CacheDir
from .trace_compiler import TraceCompiler
# from .coverage_report import CoverageReport # <-- Include this once testing the report

# Also include StaleCacheError from trace_compiler as it's a public exception
from .trace_compiler import StaleCacheError