# parser/nodes.py
"""
Defines the AST (Abstract Syntax Tree) node classes for the Piggly parser.

This is a Python port of the Ruby `nodes.rb` and `traversal.rb` files.
"""

from pyparsing import ParseResults

# --- Tagging System (from nodes.rb) ---
# This replicates the tag registry logic from the Ruby version.

class Tag:
    """Base class for all tags."""
    _id_counter = 0
    def __init__(self, prefix=None, id=None):
        if id is None:
            Tag._id_counter += 1
            id = Tag._id_counter
        self.id = id
        self.prefix = prefix

class EvaluationTag(Tag): pass
class BlockTag(Tag): pass
class ConditionalLoopTag(Tag): pass
class UnconditionalLoopTag(Tag): pass
class ConditionalBranchTag(Tag): pass

# "we maintain the Tags in a separate collection" - nodes.rb
TAG_REGISTRY = {}

def register_tag(tag):
    """Adds a tag to the global registry and returns it."""
    TAG_REGISTRY[tag.id] = tag
    return tag

# --- Base Node Class ---

class Node:
    """
    Base class for all AST nodes. It replaces Treetop::Runtime::SyntaxNode.
    """
    
    def __init__(self, s, loc, toks, original_text=None):
        """
        :param s: The string being parsed (likely lowercase).
        :param loc: The start location of this node in 's'.
        :param toks: The pyparsing ParseResults object or list of tokens.
        :param original_text: The original, unaltered source string.
        """
        self.s = s
        self.loc = loc
        self._toks = toks
        self._original_text = original_text
        self._tag_id = None
        self._parent = None
        self._name_in_parent = None # The name this node has in its parent's results
        
        # This end_loc is an approximation if toks is not a ParseResults obj
        end_loc_val = getattr(toks, 'end_loc', None)
        
        # If end_loc exists and is not an empty string, cast it to int; otherwise, use loc.
        self._end_loc = int(end_loc_val) if end_loc_val else loc

    @property
    def parent(self):
        return self._parent
        
    @parent.setter
    def parent(self, p):
        """
        Sets the parent and recursively links children.
        This is called by the parse action factory.
        """
        self._parent = p
        if isinstance(self._toks, (ParseResults, list)):
            for item in self._toks:
                if isinstance(item, Node):
                    item._parent = self
                    # Try to find the name this child was given in pyparsing
                    if isinstance(self._toks, ParseResults):
                        for key, val in self._toks.items():
                            if val is item:
                                item._name_in_parent = key
                                break
                            elif isinstance(val, (ParseResults, list)) and item in val:
                                item._name_in_parent = key
                                break

    # In src/parser/nodes.py, inside the Node class:

    @property
    def source_text(self):
        """
        Returns the original, unmodified text for this node.
        Equivalent to the Ruby 'source_text' method.
        """
        if self._original_text is not None:
            
            # 1. Safely determine the end index.
            # Check if attribute exists AND if the value is not an empty string ('')
            if hasattr(self._toks, 'end_loc') and self._toks.end_loc:
                # Value exists and is not empty, use the live value, safely cast to int.
                end_index = int(self._toks.end_loc)
            else:
                # Value is missing or empty, use the safe integer stored in self._end_loc
                end_index = self._end_loc

            return self._original_text[self.loc:end_index]
        
        # Fallback if original_text wasn't provided
        return self.text_value

    @property
    def text_value(self):
        """
        Returns the parsed text (likely lowercase).
        Equivalent to the Ruby 'text_value' method.
        """
        if hasattr(self._toks, 'end_loc'):
            return self.s[self.loc:self._toks.end_loc]
        return self.s[self.loc:self._end_loc]

    # --- Traversal Methods (from traversal.rb) ---
    
    def walk(self):
        """
        Yields self, then recursively yields all child Nodes.
        This is the Python equivalent of 'flatten' or 'inject'.
        """
        yield self
        if isinstance(self._toks, (ParseResults, list)):
            for item in self._toks:
                if isinstance(item, Node):
                    yield from item.walk()

    def find(self, predicate):
        """
        Finds the first node (including self) that matches the predicate.
        :param predicate: A function(node) -> bool
        """
        return next((n for n in self.walk() if predicate(n)), None)
    
    def select(self, predicate):
        """
        Selects all nodes (including self) that match the predicate.
        :param predicate: A function(node) -> bool
        """
        return [n for n in self.walk() if predicate(n)]

    # --- Tagging Methods (from nodes.rb) ---
    
    def tag(self, prefix=None, id=None):
        if self._tag_id is None:
            if self.named("body"):
                tag_obj = BlockTag(prefix, id)
            else:
                tag_obj = EvaluationTag(prefix, id)
            register_tag(tag_obj)
            self._tag_id = tag_obj.id
        return TAG_REGISTRY.get(self._tag_id) # Return the full tag

    @property
    def tag_id(self):
        if self._tag_id is None:
            raise RuntimeError("Node is not tagged")
        return self._tag_id
    
    @property
    def is_tagged(self):
        return self._tag_id is not None
    
    # --- Type-checking Methods (from nodes.rb) ---
    
    def named(self, label):
        """
        True if this node is called 'label' by its parent node.
        (e.g., node.named("cond"))
        """
        return self._name_in_parent == label
        
    # Default implementations
    def is_expression(self): return False
    def is_branch(self): return False
    def is_block(self): return False
    def is_stub(self): return False
    def is_loop(self): return False
    def is_for(self): return False
    def is_while(self): return False
    def style(self): return None
    def is_comment(self): return False
    def is_whitespace(self): return False
    def is_token(self): return False
    def is_string(self): return False
    def is_datatype(self): return False
    def is_identifier(self): return False
    def is_assignment(self): return False
    def is_sql(self): return False
    def is_statement(self): return False
    def is_if(self): return False
    def is_else(self): return False
    def is_label(self): return False
    def is_keyword(self): return False
    def is_terminal(self): return False


# --- Specific Node Subclasses (from nodes.rb) ---

class Statement(Node):
    def is_statement(self): return True
    def is_terminal(self): return False

class Expression(Node):
    def is_expression(self): return True
    def is_terminal(self): return False
    
    def tag(self, prefix=None, id=None):
        if self._tag_id is None:
            tag_class = EvaluationTag # Default
            if self.named("cond"):
                p = self.parent
                if p and p.is_while():
                    tag_class = ConditionalLoopTag
                elif p and p.is_loop():
                    tag_class = UnconditionalLoopTag
                elif p and p.is_branch():
                    tag_class = ConditionalBranchTag
            
            tag_obj = tag_class(prefix, id)
            register_tag(tag_obj)
            self._tag_id = tag_obj.id
        return TAG_REGISTRY.get(self._tag_id)

class Block(Statement):
    def is_block(self): return True

class Branch(Statement):
    def is_branch(self): return True

class If(Branch):
    def is_if(self): return True
    def is_terminal(self): return False

class Else(Node):
    def is_else(self): return True
    def is_terminal(self): return False

class Catch(Branch): pass
class CaseWhen(Branch): pass
class CondWhen(Branch): pass
class ContinueWhen(Branch): pass
class ExitWhen(Branch): pass

class UnconditionalBranch(Statement): pass
class Return(UnconditionalBranch): pass
class Exit(UnconditionalBranch): pass
class Continue(UnconditionalBranch): pass
class Throw(UnconditionalBranch): pass

class Loop(Statement):
    def is_loop(self): return True

class ForLoop(Loop):
    def is_for(self): return True

class ForEachLoop(Loop):
    def is_for(self): return True # As per Ruby code

class WhileLoop(Loop):
    def is_while(self): return True

class Raise(Statement): pass
class Case(Statement): pass
class Cond(Statement): pass

class Assignment(Statement):
    def is_assignment(self): return True

class Assignable(Node): pass

class Sql(Expression):
    def style(self): return "tQ"
    def is_sql(self): return True
    
    def tag(self, prefix=None, id=None):
        if self._tag_id is None:
            tag_class = EvaluationTag
            p = self.parent
            if self.named("cond") and p and p.is_for():
                tag_class = UnconditionalLoopTag
            
            tag_obj = tag_class(prefix, id)
            register_tag(tag_obj)
            self._tag_id = tag_obj.id
        return TAG_REGISTRY.get(self._tag_id)

class Terminal(Node):
    def __init__(self, s, loc, toks, original_text=None):
        # "Third argument nil prevents children from being assigned"
        # We achieve this by passing an empty list for toks
        super().__init__(s, loc, [], original_text)
        self._end_loc = toks.end_loc if hasattr(toks, 'end_loc') else loc

    def is_terminal(self): return True

class TWhitespace(Node):
    def is_terminal(self): return False
    def is_whitespace(self): return True

class Token(Terminal):
    def is_token(self): return True

class TKeyword(Token):
    def style(self): return "tK"
    def is_keyword(self): return True
    
    def tag(self, prefix=None, id=None):
        if self._tag_id is None:
            tag_class = EvaluationTag
            p = self.parent
            if self.named("cond") and p and p.is_loop():
                tag_class = UnconditionalLoopTag
            
            tag_obj = tag_class(prefix, id)
            register_tag(tag_obj)
            self._tag_id = tag_obj.id
        return TAG_REGISTRY.get(self._tag_id)

class TIdentifier(Token):
    def style(self): return "tI"
    def is_identifier(self): return True

class TDatatype(Token):
    def style(self): return "tD"
    def is_datatype(self): return True

class TString(Token):
    def style(self): return "tS"
    def is_string(self): return True

class TDollarQuoteMarker(Token):
    def style(self): return "tM"

class TComment(Token):
    def style(self): return "tC"
    def is_comment(self): return True

class TLabel(Token):
    def style(self): return "tL"
    def is_label(self): return True

class TextNode(Terminal): pass

class StubNode(Terminal):
    def is_stub(self): return True

class NotImplementedNode(Node):
    def __init__(self, s, loc, toks, original_text=None):
        super().__init__(s, loc, toks, original_text)
        # This was in `parent=` in Ruby, moving to __init__
        # A helper function could be used to find line/col from loc
        raise RuntimeError(
            f"Grammar does not implement node near '{self.text_value}' at loc {self.loc}"
        )