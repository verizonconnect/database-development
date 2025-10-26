# parser/__init__.py
"""
PL/pgSQL Parser public interface.

This is a Python port of the Ruby `parser.rb` file.
"""

from pyparsing import ParseException
from . import grammar  # Imports your grammar.py
from .nodes import * # Makes all node types available (e.g., parser.Block)

class ParserError(RuntimeError):
    """Custom exception for parsing failures."""
    pass

def parse(text: str):
    """
    Parses a Pl/pgSQL string and returns the root AST node.

    :param text: The original (unmodified) PL/pgSQL source code.
    :return: The root Node (likely a Block) of the parsed AST.
    """
    
    # This is a mutable reference (a list with one item) that we
    # can pass to the parse action factory. This allows all nodes
    # to get a reference to the original, unaltered text.
    original_text_ref = [text]
    
    # 1. Get a parser instance from your grammar factory.
    #    This factory will wire up all parse actions.
    #    (See next section on how to build this).
    parser = grammar.get_parser(original_text_ref)
    
    # 2. Downcase the input, just like the Ruby version.
    lowercase_text = text.lower()
    
    try:
        # 3. Parse the downcased string.
        #    parse_all=True ensures the entire string is matched.
        results = parser.parse_string(lowercase_text, parse_all=True)
        
        # 4. The result of parse_string is a ParseResults list.
        #    Our parse action on the top-level rule ensures the
        #    first element is our custom Node instance.
        if results and len(results) > 0:
            return results[0]
        else:
            raise ParserError("Input was valid but produced no parse result.")
            
    except ParseException as e:
        # Re-raise as the expected exception type
        raise ParserError(f"Failed to parse at line {e.lineno}, col {e.col}: {e.msg}")

    # The Ruby parser's `input.replace(string)` logic is
    # NOT NEEDED. Our Node.source_text method handles
    # slicing the original text directly.