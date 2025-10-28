import os
import re
import io
from typing import List, Dict, Any, TYPE_CHECKING

# Assume these modules are available in your structure
from ..parser import parse as Parser_parse
from .cache_dir import CacheDir
# from .nodes import Node, Tag # For type hinting, not execution

# Define a custom exception for consistency with the Ruby original
class StaleCacheError(RuntimeError):
    pass

class TraceCompiler:
    """
    Walks the parse tree, attaching Tag values and rewriting source code to ping them.
    This is the core compilation engine.
    """

    # Constants used for instrumentation helpers
    PIGGLY_SIGNAL_AT = "$PIGGLY$@$PIGGLY$"
    
    # Static method to find source files for staleness check
    @staticmethod
    def cache_sources() -> List[str]:
        """
        Defines the list of source files used to check cache staleness.
        (Assumes Parser structure based on Ruby original)
        """
        # In a complete Python environment, these would be absolute paths
        # corresponding to where your grammar/parser files are located.
        return [
            "src/parser/grammar.py",  # Python grammar equivalent
            "src/parser/nodes.py",    # Node definitions
            # Add other compiler dependency files if needed
        ]

    def __init__(self, config: Any):
        self.config = config # Configuration object (e.g., to access source paths)

    def _cache_path(self, source_path: str) -> str:
        """Helper to determine the cache path based on the source path."""
        # This implementation is a placeholder; real path logic depends on config
        return f"/tmp/piggly_cache/{os.path.basename(source_path)}"

    def stale(self, procedure: Any) -> bool:
        """
        Checks if the cache is older than its source or dependency files.
        (Translates Util::File.stale? using file mtimes)
        """
        source_path = procedure.source_path(self.config) # Assumed method
        cache_path = self._cache_path(source_path)
        
        # If cache path doesn't exist, it's stale
        if not os.path.exists(cache_path):
            return True

        cache_mtime = os.path.getmtime(cache_path)
        
        # Check source file mtime
        if os.path.getmtime(source_path) > cache_mtime:
            return True

        # Check dependency files
        for dep_path in self.cache_sources():
            if os.path.getmtime(dep_path) > cache_mtime:
                return True
                
        return False

    def compile(self, procedure: Any) -> CacheDir:
        """
        Parses, traverses the tree to inject tracing code, and caches the result.
        """
        source_path = procedure.source_path(self.config) # Assumed method
        cache = CacheDir(self._cache_path(source_path))

        if self.stale(procedure):
            try:
                print(f"Compiling {procedure.name}")
                
                # 1. Parse the source code
                with open(source_path, 'r', encoding='utf-8') as f:
                    source_string = f.read()
                    
                # Parser_parse returns the root Node object (no Thunk/force! needed in Python)
                tree = Parser_parse(source_string) 

                tags = []
                # 2. Traverse and inject tracing code
                code = self._traverse(tree, procedure.oid, tags)

                # 3. Cache the results
                cache.replace({"tree": tree, "code": code, "tags": tags})
                
            except RuntimeError as e:
                # Simplified exception logging (replaces Ruby's HEREDOC)
                error_msg = f"""
                ****
                Error compiling procedure {procedure.name}
                Source: {source_path}
                Exception Message:
                {e.args[0] if e.args else str(e)}
                ****
                """
                print(error_msg, file=os.sys.stderr)
            except Exception as e:
                # Catch general errors during file I/O or parsing
                print(f"Critical error during compilation of {procedure.name}: {e}", file=os.sys.stderr)

        return cache

    def _traverse(self, node: Any, oid: Any, tags: List[Any]) -> str:
        """
        Rewrites the parse tree to call instrumentation helpers and destructively
        updates `tags`.
        """
        # Node must be a terminal or an expression (like literal/variable access)
        if node.is_terminal() or node.is_expression():
            return node.source_text
        
        # Node is a non-terminal composite node (like a block or control structure)
        
        # --- CONDITIONAL INJECTION (IF/WHILE/ELSIF) ---
        if hasattr(node, 'condStub') and hasattr(node, 'cond'):
            # This logic preserves leading parenthesis/whitespace before the condition
            cond_value = node.cond.text_value
            match = re.match(r"\A(\s*\(?)(.+)\Z", cond_value, re.DOTALL)
            
            # Match is expected to capture pre-whitespace/paren and the actual condition
            if match:
                pre, cond = match.groups()
            else:
                # Fallback in case regex fails (shouldn't happen with the Python re.DOTALL)
                pre, cond = "", cond_value.strip()

            node.cond.source_text = ""  # Erase original source text (it's now injected)

            tags.append(node.cond.tag(oid))

            # Rewrite condStub to inject the instrumentation call
            # Ruby: "#{pre}public.piggly_cond($PIGGLY$#{node.cond.tag_id}$PIGGLY$, (#{cond}))"
            stub_code = f"{pre}public.piggly_cond($PIGGLY${node.cond.tag_id}$PIGGLY$, ({cond}))"
            
            # Preserve trailing whitespace (node.cond.tail is assumed to be a Node property)
            stub_code += self._traverse(node.cond.tail, oid, tags) 
            node.condStub.source_text = stub_code
        
        # --- BODY INJECTION (BLOCK/LOOP) ---
        if hasattr(node, 'bodyStub'):
            
            # Special logic for Loops (stmtForLoop, stmtLoop)
            if hasattr(node, 'exitStub') and hasattr(node, 'cond'):
                
                # Check for body and cond tag existence
                if hasattr(node, 'body') and hasattr(node.body, 'tag') and \
                   hasattr(node.cond, 'tag'):
                    
                    tags.append(node.body.tag(oid))
                    tags.append(node.cond.tag(oid))

                    # Signal condition is true when body is executed
                    # Ruby: perform public.piggly_cond(TAG, true);
                    cond_signal = f"perform public.piggly_cond($PIGGLY${node.cond.tag_id}$PIGGLY$, true);"
                    
                    # Signal branch is executed
                    # Ruby: perform public.piggly_branch(TAG);
                    branch_signal = f"perform public.piggly_branch($PIGGLY${node.body.tag_id}$PIGGLY$);"
                    
                    # Construct bodyStub source
                    body_stub_code = cond_signal
                    body_stub_code += f"{node.indent('bodySpace')}{branch_signal}"
                    
                    node.bodyStub.source_text = body_stub_code
                    
                    if hasattr(node, 'doneStub'):
                        # Signal the end of an iteration was reached
                        # Ruby: perform public.piggly_signal(TAG, '@');
                        done_stub_code = f"{node.indent('bodySpace')}perform public.piggly_signal($PIGGLY${node.cond.tag_id}$PIGGLY$, {self.PIGGLY_SIGNAL_AT});"
                        # node.body.indent is assumed to return the appropriate indentation string
                        done_stub_code += node.body.indent()
                        node.doneStub.source_text = done_stub_code

                    # Signal the loop terminated (in exitStub)
                    # Ruby: perform public.piggly_cond(TAG, false);
                    exit_stub_code = f"\n{node.indent()}perform public.piggly_cond($PIGGLY${node.cond.tag_id}$PIGGLY$, false);"
                    node.exitStub.source_text = exit_stub_code
            
            # Logic for Blocks, simple Else, EXIT, CONTINUE (Unconditional Branches)
            elif hasattr(node, 'body') and hasattr(node.body, 'tag'):
                tags.append(node.body.tag(oid))
                
                # Ruby: perform public.piggly_branch(TAG);
                signal = f"perform public.piggly_branch($PIGGLY${node.body.tag_id}$PIGGLY$);"
                node.bodyStub.source_text = f"{signal}{node.indent('bodySpace')}"

        # Recurse through children to get the rewritten source text
        # Assumes Node.elements property is available for children.
        rewritten_children = [self._traverse(e, oid, tags) for e in node.elements]
        return "".join(rewritten_children)