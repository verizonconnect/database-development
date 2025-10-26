import re
import sys
from typing import List, Dict, Any, Callable, Optional
from collections import defaultdict

# --- Placeholder Dependencies ---

# Assuming this module exists and contains the necessary static methods
from .util.enumerable import Enumerable 

# These placeholders represent classes imported from other parts of the project
class AbstractTag:
    # This pattern is used by the notice_processor
    PATTERN = r'[0-9a-fA-F]{32}' 
    
    def ping(self, value: Optional[str] = None): pass
    def clear(self): pass
    def to_f(self) -> float: return 0.0 
    
    # Placeholder for the type identifier (e.g., 'branch', 'loop')
    @property
    def type(self) -> str: return "unknown" 

class Tags:
    AbstractTag = AbstractTag
    # Add other tag classes as needed

class DumperReifiedProcedure: # Placeholder
    def signature(self): pass
    def oid(self): pass

class DumperSkeletonProcedure: # Placeholder
    def signature(self): pass
    def oid(self): pass

# --- Profile Class ---

class Profile:
    """
    Collection of all Tags, managing coverage stats and processing trace messages.
    (Translation of Piggly::Profile)
    """

    def __init__(self):
        # Ruby: @by_id, @by_cache, @by_procedure = {}, {}, {}
        self._by_id: Dict[str, AbstractTag] = {}
        self._by_cache: Dict[Any, List[AbstractTag]] = {}
        self._by_procedure: Dict[str, List[AbstractTag]] = {}

    def add(self, procedure: Any, tags: List[AbstractTag], cache: Any = None):
        """Register a procedure and its list of tags."""
        # tags.each{|t| @by_id[t.id] = t }
        for t in tags:
            self._by_id[t.id] = t
            
        # @by_cache[cache] = tags unless cache.nil?
        if cache is not None:
            self._by_cache[cache] = tags
            
        # @by_procedure[procedure.oid] = tags
        self._by_procedure[procedure.oid()] = tags
        
    def __getitem__(self, obj: Any) -> Any:
        """Accesses tags by ID (string) or by procedure (object)."""
        
        # case object when String
        if isinstance(obj, str):
            tag = self._by_id.get(obj)
            if tag is None:
                raise RuntimeError(f"No tag with id {obj}")
            return tag
            
        # case object when Dumper::ReifiedProcedure, Dumper::SkeletonProcedure
        elif isinstance(obj, (DumperReifiedProcedure, DumperSkeletonProcedure)):
            tags = self._by_procedure.get(obj.oid())
            if tags is None:
                raise RuntimeError(f"No tags for procedure {obj.signature()}")
            return tags
        else:
            raise TypeError(f"Profile lookup supports str (tag_id) or Procedure objects, got {type(obj).__name__}")

    def ping(self, tag_id: str, value: Optional[str] = None):
        """Record the execution of a coverage tag."""
        self[tag_id].ping(value)

    def summary(self, procedure: Optional[Any] = None) -> Dict[str, Dict[str, Any]]:
        """Summarizes coverage for each type of tag (branch, block, loop)."""
        
        # Select tags based on procedure or all tags
        if procedure:
            if procedure.oid() in self._by_procedure:
                tags = self._by_procedure[procedure.oid()]
            else:
                tags = []
        else:
            tags = list(self._by_id.values())

        # grouped = Util::Enumerable.group_by(tags){|x| x.type }
        grouped = Enumerable.group_by(tags, lambda x: x.type)

        # summary = Hash.new{|h,k| h[k] = Hash.new }
        summary = defaultdict(dict)
        
        for type_name, ts in grouped.items():
            # summary[type][:count] = ts.size
            summary[type_name]["count"] = len(ts)
            
            # summary[type][:percent] = Util::Enumerable.sum(ts){|x| x.to_f } / ts.size
            total_sum = Enumerable.sum(ts, transform_func=lambda x: x.to_f())
            summary[type_name]["percent"] = total_sum / len(ts) if ts else 0.0

        return dict(summary)

    def clear(self):
        """Resets each tag's coverage stats."""
        # @by_id.values.each{|x| x.clear }
        for tag in self._by_id.values():
            tag.clear()

    def store(self):
        """Write coverage stats to the disk cache."""
        # @by_cache.each{|cache, tags| cache[:tags] = tags }
        for cache, tags in self._by_cache.items():
            # Assumes cache object (CacheDir instance) supports dict-like assignment
            cache["tags"] = tags

    def empty(self, tags: List[AbstractTag]) -> bool:
        """Checks if all tags in the list have zero coverage."""
        # tags.all?{|t| t.to_f.zero? }
        return all(t.to_f() == 0.0 for t in tags)

    def difference(self, procedure: Any, tags: List[AbstractTag]) -> str:
        """Calculates the coverage difference between current and previous runs."""
        
        current_tags = self._by_procedure.get(procedure.oid(), [])
        
        # Util::Enumerable.group_by(@by_procedure[procedure.oid]){|x| x.type }
        current = Enumerable.group_by(current_tags, lambda x: x.type)
        previous = Enumerable.group_by(tags, lambda x: x.type)

        # Use Python sets for key union
        all_types = set(current.keys()) | set(previous.keys())

        results = []
        for type_name in all_types:
            # Handle default=[] outside the Enumerable class
            current_ts = current.get(type_name, [])
            previous_ts = previous.get(type_name, [])

            def calculate_percent(ts):
                if not ts:
                    return 0.0
                # Util::Enumerable.sum(ts){|x| x.to_f } / ts.size
                total_sum = Enumerable.sum(ts, transform_func=lambda x: x.to_f())
                return total_sum / len(ts)

            current_pct = calculate_percent(current_ts)
            previous_pct = calculate_percent(previous_ts)
            
            # pct = current_pct - previous_pct
            pct_diff = current_pct - previous_pct

            # Ruby: "#{"%+0.1f" % pct}% #{type}"
            results.append(f"{pct_diff:+.1f}% {type_name}")

        # Ruby: .join(", ")
        return ", ".join(results)

    def notice_processor(self, config: Any) -> Callable[[str], None]:
        """Builds a function that records each tag execution from PostgreSQL notices."""
        
        # pattern = /#{config.trace_prefix} (#{Tags::AbstractTag::PATTERN})(?: (.))?/
        trace_prefix = getattr(config, 'trace_prefix', 'PIGGLY')
        tag_pattern = Tags.AbstractTag.PATTERN
        
        pattern_str = f"^{trace_prefix} ({tag_pattern})(?: (.))?"
        pattern = re.compile(pattern_str)

        def processor(message: str):
            m = pattern.match(message)
            
            if m:
                # Group 1 is tag_id, Group 2 is value (t/f or signal)
                tag_id, value = m.groups()
                self.ping(tag_id, value)
            else:
                # Ruby: stderr.puts("unknown trace: #{message}")
                sys.stderr.write(f"unknown trace: {message}\n")
                
        return processor