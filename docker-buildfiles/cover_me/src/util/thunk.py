from typing import Any, Optional, Callable

class Thunk(object):
    """
    Wraps a computation and delays its evaluation until a message is sent to it. 
    Computation can be forced by calling `force()`.
    (Translation of Piggly::Util::Thunk)
    """

    def __init__(self, block: Callable[[], Any]):
        # Manually set attributes to avoid invoking __getattr__ during initialization
        object.__setattr__(self, '_block', block)
        object.__setattr__(self, '_value', None)

    def force(self) -> Any:
        """
        Forces the computation of the wrapped block if it hasn't been evaluated.
        (Translates Ruby's force!)
        """
        # Ruby: unless @block.nil?
        if object.__getattribute__(self, '_block') is not None:
            # Ruby: @value = @block.call
            value = object.__getattribute__(self, '_block')()
            object.__setattr__(self, '_value', value)
            # Ruby: @block = nil
            object.__setattr__(self, '_block', None)
        
        return object.__getattribute__(self, '_value')

    def thunk(self) -> bool:
        """Indicates that the object is a Thunk."""
        return True

    # Python's equivalent of Ruby's method_missing is __getattr__.
    def __getattr__(self, name: str) -> Any:
        # Prevents infinite recursion
        if name in ['_block', '_value', 'force', 'thunk']:
            return object.__getattribute__(self, name)
            
        # Force evaluation and delegate the method call
        forced_value = self.force()
        # Ruby: force!.send(name, *args, &block)
        return getattr(forced_value, name)