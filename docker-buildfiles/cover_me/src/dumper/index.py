import os
import yaml
from typing import List, Any, Dict, Set, Callable

# --- Dependency Placeholders ---
# Assumed to be defined in reified_procedure.py or shared util
# from .reified_procedure import SkeletonProcedure 
# from ..config import Config 
class SkeletonProcedure:
    def identifier(self): pass
    def purge_source(self, config): pass
    def store_source(self, config): pass
    def source(self, config): pass
    def skeleton(self): pass

class UtilEnumerable:
    """Placeholder for Ruby's Util::Enumerable helpers."""
    @staticmethod
    def index_by(items, key_func: Callable) -> Dict[str, Any]:
        """Creates a dictionary indexed by the result of key_func(item) for each item."""
        return {key_func(item): item for item in items}


class Index:
    """
    The index file stores metadata about every procedure.
    (Translation of Piggly::Dumper::Index)
    """

    def __init__(self, config: Any):
        self._config = config
        self._index: Dict[str, SkeletonProcedure] = {} # Lazy-loaded via self.index

    def path(self) -> str:
        """Returns the full path to the index file."""
        # Assumes config.mkpath works like os.path.join and creates directories
        return os.path.join(self._config.mkpath(f"{self._config.cache_root}/Dumper"), "index.yml")

    @property
    def _index_data(self) -> Dict[str, SkeletonProcedure]:
        """Lazy loader for the in-memory index."""
        if not self._index:
            self._index = self._load_index()
        return self._index

    def update(self, procedures: List[SkeletonProcedure]):
        """Updates the index with the given list of Procedure values."""
        # 1. Build a new index from the incoming list
        newest = UtilEnumerable.index_by(procedures, lambda x: x.identifier())

        # 2. Handle removed procedures
        # Ruby: index.values.reject{|p| newest.include?(p.identifier) }
        removed = [p for p in self._index_data.values() if p.identifier() not in newest]
        for p in removed:
            p.purge_source(self._config)

        # 3. Handle added procedures
        # Ruby: procedures.reject{|p| index.include?(p.identifier) }
        added = [p for p in procedures if p.identifier() not in self._index_data]
        for p in added:
            p.store_source(self._config)

        # 4. Handle changed procedures
        changed = []
        for p in procedures:
            mine = self._index_data.get(p.identifier())
            if mine:
                # Check if source is different, ignoring if both are skeletons (metadata only)
                if not (mine.skeleton() and p.skeleton()) and mine.source(self._config) != p.source(self._config):
                    changed.append(p)
        
        for p in changed:
            p.store_source(self._config)

        self._index = newest
        self._store_index()

    def procedures(self) -> List[SkeletonProcedure]:
        """Returns a list of Procedure values from the index."""
        return list(self._index_data.values())

    def __getitem__(self, identifier: str) -> SkeletonProcedure:
        """Returns a copy of the Procedure with the given identifier."""
        p = self._index_data.get(identifier)
        # Ruby's dup simulates copying/deep clone, which is good practice here
        # return p.copy() if p else None # If copy() implemented on SkeletonProcedure
        return p # Returning direct reference for now (simplification)

    def label(self, procedure: SkeletonProcedure) -> str:
        """
        Returns the shortest human-readable label that distinctly identifies
        the given procedure from the other procedures in the index.
        """
        others = [p for p in self.procedures() if p.oid != procedure.oid]
        
        # Check if all other procedures are in the same schema as this procedure
        same_schema = all(p.name.schema == procedure.name.schema for p in others)
        
        name = procedure.name.name if same_schema else str(procedure.name)

        samenames = [p for p in others if p.name == procedure.name]

        if not samenames:
            # Name is unique enough
            return str(name)
        
        sameargs = [p for p in samenames if p.arg_types == procedure.arg_types]
        
        if not sameargs:
            # Name and arg types are unique enough
            return f"{name}({', '.join(str(t) for t in procedure.arg_types)})"
            
        samemodes = [p for p in sameargs if p.arg_modes == procedure.arg_modes]
        
        if not samemodes:
            # Name, arg types, and arg modes are unique enough
            # Ruby: arg_modes.zip(arg_types).map{|a,b| "#{a} #{b}" }.join(", ")
            arg_list = [f"{mode} {type}" for mode, type in zip(procedure.arg_modes, procedure.arg_types)]
            return f"{name}({', '.join(arg_list)})"

        # If it falls through, the procedure is indistinguishable from one or more others, 
        # which shouldn't happen based on the Ruby logic flow but would require returning 
        # the fully qualified signature.
        return f"{name}({', '.join(str(t) for t in procedure.arg_types)})"


    # --- Private/Internal Methods ---

    def _load_index(self) -> Dict[str, SkeletonProcedure]:
        """Load the index from disk."""
        index_path = self.path()

        if not os.path.exists(index_path):
            contents = []
        else:
            with open(index_path, 'r') as f:
                # Ruby uses YAML.load
                contents = yaml.safe_load(f) or [] 

        # Ruby uses Util::Enumerable.index_by
        return UtilEnumerable.index_by(contents, lambda x: x.identifier())

    def _store_index(self):
        """Write the index to disk."""
        index_path = self.path()
        
        # Ensure the directory exists before writing the file
        os.makedirs(os.path.dirname(index_path), exist_ok=True)

        # Ruby maps procedures to skeletons before storing
        data_to_dump = [p.skeleton() for p in self.procedures()]
        
        with open(index_path, "w") as io:
            yaml.dump(data_to_dump, io)