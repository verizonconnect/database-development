# tests/test_pyparsing_grammar.py
import pytest
import pyparsing as pp

# Import the public 'parse' function and 'ParserError'
from src.parser import parse, ParserError

def test_start_simple():
    """Test the basic start rule with a stubbed block."""
    test_code = "BEGIN END"
    try:
        # parse_string with parse_all=True ensures the whole string matches
        result = parse(test_code)
        from src.parser.nodes import Block
        assert isinstance(result, Block)
        print(f"\nParsed '{test_code}': {result.source_text}")
        # Basic assertion: if it parses without error, it's a start
        assert result is not None
    except pp.ParseException as e:
        pytest.fail(f"Parsing failed for '{test_code}':\n{e.explain()}")

#def test_start_with_space_and_semi():
#    """Test with optional whitespace and semicolon."""
#    test_code = "  BEGIN END ; "
#    try:
#        # parse_string with parse_all=True ensures the whole string matches
#        result = parse(test_code)
#        print(f"\nParsed '{test_code}': {result.source_text}")
#        # Basic assertion: if it parses without error, it's a start
#        assert result is not None
#    except pp.ParseException as e:
#        pytest.fail(f"Parsing failed for '{test_code}':\n{e.explain()}")
#
#def test_start_with_comments():
#    """Test with comments ignored."""
#    test_code = """
#    -- Leading comment
#    BEGIN /* Block comment */
#    END; -- Trailing comment
#    """
#    try:
#        # parse_string with parse_all=True ensures the whole string matches
#        result = parse(test_code)
#        print(f"\nParsed '{test_code}': {result.source_text}")
#        # Basic assertion: if it parses without error, it's a start
#        assert result is not None
#    except pp.ParseException as e:
#        pytest.fail(f"Parsing failed for '{test_code}':\n{e.explain()}")
#
#def test_null_statement():
#    """Test with comments ignored."""
#    test_code = """
#    -- Leading comment
#    BEGIN
#    NULL; -- Line Comment
#    END; -- Trailing comment
#    """
#    try:
#        # parse_string with parse_all=True ensures the whole string matches
#        result = parse(test_code)
#        print(f"\nParsed '{test_code}': {result.source_text}")
#        # Basic assertion: if it parses without error, it's a start
#        assert result is not None
#    except pp.ParseException as e:
#        pytest.fail(f"Parsing failed for '{test_code}':\n{e.explain()}")
#
#def test_select_statement():
#    """Test with comments ignored."""
#    test_code = """
#    -- Leading comment
#    BEGIN
#        SELECT t.col1, t.col2
#        FROM   sch.tbl AS t;
#    END; -- Trailing comment
#    """
#    try:
#        # parse_string with parse_all=True ensures the whole string matches
#        result = parse(test_code)
#        print(f"\nParsed '{test_code}': {result.source_text}")
#        # Basic assertion: if it parses without error, it's a start
#        assert result is not None
#    except pp.ParseException as e:
#        pytest.fail(f"Parsing failed for '{test_code}':\n{e.explain()}")
#       
#def test_delete_statement():
#    """Test with comments ignored."""
#    test_code = """
#    -- Leading comment
#    BEGIN
#        DELETE
#        FROM   sch.tbl
#        WHERE  col1 = 'del'
#               AND col2 like 'start%';
#    END; -- Trailing comment
#    """
#    try:
#        # parse_string with parse_all=True ensures the whole string matches
#        result = parse(test_code)
#        print(f"\nParsed '{test_code}': {result.source_text}")
#        # Basic assertion: if it parses without error, it's a start
#        assert result is not None
#    except pp.ParseException as e:
#        pytest.fail(f"Parsing failed for '{test_code}':\n{e.explain()}")
#        
#def test_update_statement():
#    """Test with comments ignored."""
#    test_code = """
#    -- Leading comment
#    BEGIN
#        UPDATE sch.tbl
#        SET    col3 = 'china'
#        WHERE  col1 = 'upd'
#               AND col2 like 'start%';
#    END; -- Trailing comment
#    """
#    try:
#        # parse_string with parse_all=True ensures the whole string matches
#        result = parse(test_code)
#        print(f"\nParsed '{test_code}': {result.source_text}")
#        # Basic assertion: if it parses without error, it's a start
#        assert result is not None
#    except pp.ParseException as e:
#        pytest.fail(f"Parsing failed for '{test_code}':\n{e.explain()}")
#
#def test_insert_statement():
#    """Test with comments ignored."""
#    test_code = """
#    -- Leading comment
#    BEGIN
#        INSERT INTO sch.tbl (
#            ,col1
#            ,col2
#            ,col3
#        )
#        VALUES (
#            ,'ins'
#            ,'start-me'
#            ,'india'
#        );
#    END; -- Trailing comment
#    """
#    try:
#        # parse_string with parse_all=True ensures the whole string matches
#        result = parse(test_code)
#        print(f"\nParsed '{test_code}': {result.source_text}")
#        # Basic assertion: if it parses without error, it's a start
#        assert result is not None
#    except pp.ParseException as e:
#        pytest.fail(f"Parsing failed for '{test_code}':\n{e.explain()}")
#
def test_if_flow():
    """Test with comments ignored."""
    test_code = """
    -- Leading comment
    BEGIN
        IF _param = 'value' THEN
            INSERT INTO sch.tbl (
                ,col1
                ,col2
                ,col3
            )
            VALUES (
                ,'ins'
                ,'start-me'
                ,'india'
            );
        ELSE
            UPDATE sch.tbl
            SET    col3 = 'china'
            WHERE  col1 = 'upd'
                   AND col2 like 'start%';
        END IF;
    END; -- Trailing comment
    """
    try:
        # parse_string with parse_all=True ensures the whole string matches
        result = parse(test_code)
        print(f"\nParsed '{test_code}': {result.source_text}")
        # Basic assertion: if it parses without error, it's a start
        assert result is not None
    except pp.ParseException as e:
        pytest.fail(f"Parsing failed for '{test_code}':\n{e.explain()}")
        
# --- Expected Failure Test ---
# def test_start_fail_incomplete():
#    """Test that incomplete input fails."""
#    test_code = "BEGIN" # Missing END
#    with pytest.raises(pp.ParseException):
#        start.parse_string(test_code, parse_all=True)