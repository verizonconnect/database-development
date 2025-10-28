import sys
import os
import time
from concurrent.futures import ProcessPoolExecutor, as_completed
from typing import List, Optional, Callable, Any

class ProcessQueue:
    """
    Executes callable blocks in parallel subprocesses.
    (Translation of Piggly::Util::ProcessQueue)
    """
    
    # Class-level state management (Ruby's self.concurrent)
    _concurrent: Optional[int] = None

    @classmethod
    def set_concurrent(cls, count: int):
        """Sets the maximum number of concurrent processes."""
        cls._concurrent = count

    @classmethod
    def get_concurrent(cls) -> int:
        """Returns the maximum number of concurrent processes, defaulting to 1."""
        return cls._concurrent if cls._concurrent is not None else 1

    def __init__(self, concurrent: Optional[int] = None):
        # Ruby: @concurrent, @items = concurrent, []
        self._concurrent = concurrent if concurrent is not None else self.get_concurrent()
        self._items: List[Callable[[], Any]] = []

    @property
    def concurrent(self) -> int:
        return self._concurrent

    @concurrent.setter
    def concurrent(self, value: int):
        # Ruby: def concurrent=(value)
        self._concurrent = value

    @property
    def size(self) -> int:
        # Ruby: def size
        return len(self._items)

    def queue(self, block: Callable[[], Any]):
        # Ruby: def queue(&block)
        self._items.append(block)

    add = queue # Ruby: alias add queue

    def _execute_concurrently(self):
        """
        Executes blocks in parallel using a ProcessPoolExecutor.
        (Translates Ruby's concurrently)
        """
        # Ruby: $stderr.puts "ProcessQueue running concurrently"
        sys.stderr.write("ProcessQueue running concurrently\n")

        # Use ProcessPoolExecutor for safe, high-level process management
        with ProcessPoolExecutor(max_workers=self._concurrent) as executor:
            futures = []
            
            # Ruby: while block = @items.shift
            while self._items:
                block = self._items.pop(0) 
                
                future = executor.submit(block)
                futures.append(future)
                
            # Wait for all futures to complete and check for exceptions
            for future in as_completed(futures):
                if future.exception() is not None:
                    # Reraise exception from child process
                    raise future.exception() 

    def _execute_serially(self):
        """
        Executes blocks one after another.
        (Translates Ruby's serially)
        """
        # Ruby: $stderr.puts "ProcessQueue running serially"
        sys.stderr.write("ProcessQueue running serially\n")

        # Ruby: while block = @items.shift
        while self._items:
            block = self._items.pop(0)
            block()

    def execute(self):
        """
        Executes the queued blocks, choosing concurrent or serial execution.
        """
        # Test for forkability and rely on Python's environment check
        forkable = hasattr(os, 'fork')
        
        if forkable:
            self._execute_concurrently()
        else:
            self._execute_serially()