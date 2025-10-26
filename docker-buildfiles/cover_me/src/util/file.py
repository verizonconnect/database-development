import os
import time
from typing import List, Any

class File:
    """
    Utility methods for file system operations, primarily checking staleness.
    (Translation of Piggly::Util::File)
    """

    @staticmethod
    def stale(target: str, *sources: str) -> bool:
        """
        True if the target file is older (by mtime) than any source file.
        (Translates Ruby's File.stale?)
        """
        #
        if os.path.exists(target):
            try:
                oldest_mtime = os.path.getmtime(target)
            except OSError:
                return True 
                
            #
            for source in sources:
                if not os.path.exists(source):
                    return True
                
                try:
                    source_mtime = os.path.getmtime(source)
                    if source_mtime > oldest_mtime:
                        return True
                except OSError:
                    return True 
            
            return False
        else:
            #
            return True