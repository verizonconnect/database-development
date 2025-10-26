from typing import Iterable, Any, Dict, List, Callable
from collections import defaultdict

class Enumerable:
    """
    Static helper methods for manipulating Python collections.
    (Translation of Piggly::Util::Enumerable)
    """

    @staticmethod
    def count(enum: Iterable[Any], filter_func: Callable[[Any], bool] = None) -> int:
        """
        Count number of elements, optionally filtered by a function.
        """
        if filter_func:
            return sum(1 for e in enum if filter_func(e))
        else:
            return len(list(enum))

    @staticmethod
    def sum(enum: Iterable[Any], default: Any = 0, transform_func: Callable[[Any], Any] = None) -> Any:
        """
        Compute sum of elements, optionally transformed by a function.
        """
        enum_list = list(enum)
        if not enum_list:
            return default

        if transform_func:
            return sum(transform_func(e) for e in enum_list)
        else:
            return sum(enum_list)

    @staticmethod
    def group_by(enum: Iterable[Any], key_func: Callable[[Any], Any]) -> Dict[Any, List[Any]]:
        """
        Collect elements into disjoint sets, grouped by result of the function.
        """
        result = defaultdict(list)
        for item in enum:
            result[key_func(item)].append(item)
        return dict(result)

    @staticmethod
    def index_by(enum: Iterable[Any], key_func: Callable[[Any], Any]) -> Dict[Any, Any]:
        """
        Creates a dictionary indexed by the result of the function.
        """
        return {key_func(item): item for item in enum}