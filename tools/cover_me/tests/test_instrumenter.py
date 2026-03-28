"""
Tests for the PL/pgSQL instrumenter.

Each test verifies that a specific PL/pgSQL control flow pattern is
correctly instrumented with coverage tags.
"""
import pytest
from cover_me.instrumenter import instrument, tokenise, TokenType, TagType


OID = "12345"


# ---------------------------------------------------------------------------
# Tokeniser tests
# ---------------------------------------------------------------------------

class TestTokeniser:

    def test_keyword_detection(self):
        tokens = tokenise("BEGIN IF x THEN END IF; END;")
        keywords = [t.value for t in tokens if t.type == TokenType.KEYWORD]
        assert "begin" in keywords
        assert "if" in keywords
        assert "then" in keywords
        assert "end" in keywords

    def test_single_quoted_string_opaque(self):
        tokens = tokenise("x := 'IF THEN BEGIN';")
        keywords = [t.value for t in tokens if t.type == TokenType.KEYWORD]
        assert "if" not in keywords
        assert "then" not in keywords
        assert "begin" not in keywords

    def test_dollar_quoted_string_opaque(self):
        tokens = tokenise("x := $tag$IF THEN BEGIN$tag$;")
        keywords = [t.value for t in tokens if t.type == TokenType.KEYWORD]
        assert "if" not in keywords

    def test_line_comment_opaque(self):
        tokens = tokenise("-- IF THEN BEGIN\nx := 1;")
        keywords = [t.value for t in tokens if t.type == TokenType.KEYWORD]
        assert "if" not in keywords

    def test_block_comment_opaque(self):
        tokens = tokenise("/* IF THEN BEGIN */ x := 1;")
        keywords = [t.value for t in tokens if t.type == TokenType.KEYWORD]
        assert "if" not in keywords

    def test_keyword_not_in_identifier(self):
        """'begin_date' should not match 'begin' as a keyword."""
        tokens = tokenise("begin_date := 1;")
        keywords = [t.value for t in tokens if t.type == TokenType.KEYWORD]
        assert "begin" not in keywords

    def test_line_numbers(self):
        source = "BEGIN\n  IF x THEN\n    y := 1;\n  END IF;\nEND;"
        tokens = tokenise(source)
        if_tok = [t for t in tokens if t.type == TokenType.KEYWORD and t.value == "if"][0]
        assert if_tok.line == 2


# ---------------------------------------------------------------------------
# Simple IF tests
# ---------------------------------------------------------------------------

class TestSimpleIf:

    def test_if_then(self):
        source = """BEGIN
  IF x > 0 THEN
    y := 1;
  END IF;
END;"""
        result = instrument(source, OID)
        assert "cover_me_cond(" in result.source
        assert "x > 0" in result.source
        branch_tags = [t for t in result.tags if t.tag_type == TagType.BRANCH]
        assert len(branch_tags) >= 1

    def test_if_condition_preserved(self):
        source = """BEGIN
  IF a IS NULL OR b::varchar = '' THEN
    x := 1;
  END IF;
END;"""
        result = instrument(source, OID)
        assert "a IS NULL OR b::varchar = ''" in result.source

    def test_if_else(self):
        source = """BEGIN
  IF x > 0 THEN
    y := 1;
  ELSE
    y := -1;
  END IF;
END;"""
        result = instrument(source, OID)
        assert result.source.count("cover_me_cond(") == 1
        assert result.source.count("cover_me_branch(") >= 1
        # Should have branch tags for IF cond + ELSE + BEGIN block
        branch_tags = [t for t in result.tags if t.tag_type == TagType.BRANCH]
        assert len(branch_tags) >= 2

    def test_if_elsif_else(self):
        source = """BEGIN
  IF x > 0 THEN
    result := 'positive';
  ELSIF x = 0 THEN
    result := 'zero';
  ELSIF x < 0 THEN
    result := 'negative';
  ELSE
    result := 'NULL';
  END IF;
END;"""
        result = instrument(source, OID)
        # IF + 2 ELSIF = 3 conditions
        assert result.source.count("cover_me_cond(") == 3
        # ELSE block
        else_branches = [t for t in result.tags if t.description == "ELSE branch"]
        assert len(else_branches) == 1


# ---------------------------------------------------------------------------
# Nested IF tests
# ---------------------------------------------------------------------------

class TestNestedIf:

    def test_nested_if(self):
        source = """BEGIN
  IF a THEN
    IF b THEN
      x := 1;
    END IF;
  END IF;
END;"""
        result = instrument(source, OID)
        cond_count = result.source.count("cover_me_cond(")
        assert cond_count == 2


# ---------------------------------------------------------------------------
# WHILE loop tests
# ---------------------------------------------------------------------------

class TestWhileLoop:

    def test_while_loop(self):
        source = """BEGIN
  WHILE count > 10 LOOP
    count := count - 1;
  END LOOP;
END;"""
        result = instrument(source, OID)
        assert "cover_me_cond(" in result.source
        assert "count > 10" in result.source
        loop_tags = [t for t in result.tags if t.tag_type == TagType.LOOP]
        assert len(loop_tags) >= 1

    def test_while_complex_condition(self):
        source = """BEGIN
  WHILE count > 10 AND true LOOP
    count := floor(count / 4.0);
  END LOOP;
END;"""
        result = instrument(source, OID)
        assert "count > 10 AND true" in result.source
        assert "cover_me_cond(" in result.source

    def test_while_with_label(self):
        source = """BEGIN
  << my_label >>
  WHILE NOT n = 10 LOOP
    n := 10;
  END LOOP my_label;
END;"""
        result = instrument(source, OID)
        assert "cover_me_cond(" in result.source
        assert "NOT n = 10" in result.source


# ---------------------------------------------------------------------------
# FOR loop tests
# ---------------------------------------------------------------------------

class TestForLoop:

    def test_for_numeric_range(self):
        source = """BEGIN
  FOR i IN 1 .. 10 LOOP
    ys[i] := i;
  END LOOP;
END;"""
        result = instrument(source, OID)
        loop_tags = [t for t in result.tags if t.tag_type == TagType.LOOP]
        assert len(loop_tags) >= 1
        assert "cover_me_branch(" in result.source

    def test_for_reverse(self):
        source = """BEGIN
  FOR i IN REVERSE 10..1 LOOP
    n := i;
  END LOOP;
END;"""
        result = instrument(source, OID)
        loop_tags = [t for t in result.tags if t.tag_type == TagType.LOOP]
        assert len(loop_tags) >= 1

    def test_for_query(self):
        source = """BEGIN
  FOR rec IN SELECT * FROM pg_namespace LIMIT 2 LOOP
    RETURN NEXT rec;
  END LOOP;
END;"""
        result = instrument(source, OID)
        loop_tags = [t for t in result.tags if t.tag_type == TagType.LOOP]
        assert len(loop_tags) >= 1

    def test_for_execute(self):
        source = """BEGIN
  FOR rec IN EXECUTE 'SELECT * FROM pg_namespace' LOOP
    CONTINUE;
  END LOOP;
END;"""
        result = instrument(source, OID)
        loop_tags = [t for t in result.tags if t.tag_type == TagType.LOOP]
        assert len(loop_tags) >= 1


# ---------------------------------------------------------------------------
# Bare LOOP tests
# ---------------------------------------------------------------------------

class TestBareLoop:

    def test_bare_loop_exit(self):
        source = """BEGIN
  LOOP
    a := a + 1;
    EXIT WHEN a > 10;
  END LOOP;
END;"""
        result = instrument(source, OID)
        loop_tags = [t for t in result.tags if t.tag_type == TagType.LOOP]
        assert len(loop_tags) >= 1
        exit_tags = [t for t in result.tags if "EXIT" in t.description]
        assert len(exit_tags) >= 1

    def test_bare_loop_with_label(self):
        source = """BEGIN
  << labelA >>
  LOOP
    a := a + 1;
    EXIT labelA WHEN a > 10;
  END LOOP labelA;
END;"""
        result = instrument(source, OID)
        loop_tags = [t for t in result.tags if t.tag_type == TagType.LOOP]
        assert len(loop_tags) >= 1


# ---------------------------------------------------------------------------
# EXIT / CONTINUE tests
# ---------------------------------------------------------------------------

class TestExitContinue:

    def test_exit_instrumented(self):
        source = """BEGIN
  LOOP
    EXIT;
  END LOOP;
END;"""
        result = instrument(source, OID)
        exit_tags = [t for t in result.tags if "EXIT" in t.description]
        assert len(exit_tags) == 1
        # Branch inject should appear before EXIT
        idx_branch = result.source.index("cover_me_branch(")
        idx_exit = result.source.index("exit")
        assert idx_branch < idx_exit

    def test_continue_instrumented(self):
        source = """BEGIN
  LOOP
    CONTINUE;
  END LOOP;
END;"""
        result = instrument(source, OID)
        cont_tags = [t for t in result.tags if "CONTINUE" in t.description]
        assert len(cont_tags) == 1


# ---------------------------------------------------------------------------
# RETURN tests
# ---------------------------------------------------------------------------

class TestReturn:

    def test_return_instrumented(self):
        source = """BEGIN
  RETURN 42;
END;"""
        result = instrument(source, OID)
        ret_tags = [t for t in result.tags if "RETURN" in t.description]
        assert len(ret_tags) == 1

    def test_return_next(self):
        source = """BEGIN
  RETURN NEXT rec;
END;"""
        result = instrument(source, OID)
        ret_tags = [t for t in result.tags if "RETURN" in t.description]
        assert len(ret_tags) == 1

    def test_return_void(self):
        source = """BEGIN
  IF x IS NULL THEN
    RETURN;
  END IF;
END;"""
        result = instrument(source, OID)
        ret_tags = [t for t in result.tags if "RETURN" in t.description]
        assert len(ret_tags) == 1


# ---------------------------------------------------------------------------
# RAISE tests
# ---------------------------------------------------------------------------

class TestRaise:

    def test_raise_exception_instrumented(self):
        source = """BEGIN
  RAISE EXCEPTION 'something went wrong';
END;"""
        result = instrument(source, OID)
        raise_tags = [t for t in result.tags if "RAISE EXCEPTION" in t.description]
        assert len(raise_tags) == 1

    def test_raise_notice_not_instrumented(self):
        """RAISE NOTICE/WARNING/etc should NOT be instrumented (not a branch)."""
        source = """BEGIN
  RAISE NOTICE 'hello';
  RAISE WARNING 'world';
END;"""
        result = instrument(source, OID)
        raise_tags = [t for t in result.tags if "RAISE EXCEPTION" in t.description]
        assert len(raise_tags) == 0


# ---------------------------------------------------------------------------
# EXCEPTION handler tests
# ---------------------------------------------------------------------------

class TestExceptionHandler:

    def test_exception_block(self):
        source = """BEGIN
  n := n / 0;
EXCEPTION
  WHEN division_by_zero THEN
    RAISE NOTICE 'caught';
END;"""
        result = instrument(source, OID)
        # The BEGIN block should be instrumented
        block_tags = [t for t in result.tags if t.tag_type == TagType.BLOCK]
        assert len(block_tags) >= 1


# ---------------------------------------------------------------------------
# CASE statement tests
# ---------------------------------------------------------------------------

class TestCase:

    def test_simple_case(self):
        source = """BEGIN
  CASE x
    WHEN 1 THEN
      result := 'one';
    WHEN 2 THEN
      result := 'two';
    ELSE
      result := 'other';
  END CASE;
END;"""
        result = instrument(source, OID)
        else_tags = [t for t in result.tags if t.description == "ELSE branch"]
        assert len(else_tags) == 0  # CASE ELSE is an expression — cannot instrument

    def test_searched_case(self):
        source = """BEGIN
  CASE
    WHEN b IS NULL THEN
      x := NULL;
    WHEN b BETWEEN 0 AND 10 THEN
      x := 1;
  END CASE;
END;"""
        result = instrument(source, OID)
        assert len(result.tags) > 0


# ---------------------------------------------------------------------------
# String safety tests
# ---------------------------------------------------------------------------

class TestStringSafety:

    def test_keywords_in_single_string_ignored(self):
        source = """BEGIN
  x := 'IF THEN ELSE BEGIN END LOOP WHILE';
END;"""
        result = instrument(source, OID)
        # Only BEGIN block should be tagged, not the string contents
        branch_tags = [t for t in result.tags if t.tag_type == TagType.BRANCH]
        assert len(branch_tags) == 0  # no IF/ELSE branches

    def test_keywords_in_dollar_string_ignored(self):
        source = """BEGIN
  x := $$IF THEN ELSE BEGIN END LOOP WHILE$$;
END;"""
        result = instrument(source, OID)
        branch_tags = [t for t in result.tags if t.tag_type == TagType.BRANCH]
        assert len(branch_tags) == 0

    def test_keywords_in_comments_ignored(self):
        source = """BEGIN
  -- IF THEN ELSE
  /* WHILE LOOP FOR */
  x := 1;
END;"""
        result = instrument(source, OID)
        branch_tags = [t for t in result.tags if t.tag_type == TagType.BRANCH]
        assert len(branch_tags) == 0


# ---------------------------------------------------------------------------
# Tag determinism tests
# ---------------------------------------------------------------------------

class TestTagDeterminism:

    def test_same_input_same_tags(self):
        source = """BEGIN
  IF x > 0 THEN
    y := 1;
  END IF;
END;"""
        r1 = instrument(source, OID)
        r2 = instrument(source, OID)
        assert [t.id for t in r1.tags] == [t.id for t in r2.tags]

    def test_different_oid_different_tags(self):
        source = """BEGIN
  IF x > 0 THEN
    y := 1;
  END IF;
END;"""
        r1 = instrument(source, "111")
        r2 = instrument(source, "222")
        ids1 = {t.id for t in r1.tags}
        ids2 = {t.id for t in r2.tags}
        assert ids1.isdisjoint(ids2)


# ---------------------------------------------------------------------------
# Full procedure test (snippets.sql equivalent)
# ---------------------------------------------------------------------------

class TestFullProcedure:

    def test_snippets_procedure(self):
        """Test against a complex procedure with many control flow patterns."""
        source = """
DECLARE
  x               varchar(20);
  n               integer := 403;
  result          text;
  fooValue        record;
BEGIN

  IF a <> 0 THEN
    SELECT INTO n sum(id) FROM pg_users;
  END IF;

  IF a IS NULL OR b::varchar = '' THEN
    x := 'bahut badmash!';
  ELSE
    SELECT INTO n 1;
  END IF;

  IF array_upper(ys, 1) = 0 THEN
      result := 'zero';
  ELSIF array_upper(ys, 1) > 0 THEN
      result := 'positive';
  ELSIF array_upper(ys, 1) < 0 THEN
      result := 'negative';
  ELSE
      result := 'NULL';
  END IF;

  FOR fooValue IN SELECT * FROM pg_proc LOOP
    IF fooValue.frump THEN
        result := 'man';
    ELSE
        IF fooValue.proretset IS FALSE THEN
            result := 'ULYSSES S GRUMP';
        END IF;
    END IF;
  END LOOP;

  LOOP
    EXIT WHEN n > 10;
  END LOOP;

  WHILE n > 0 LOOP
    n := n - 1;
  END LOOP;

  FOR i IN 1 .. 10 LOOP
    n := i;
  END LOOP;

  BEGIN
    n := n / 0;
  EXCEPTION
    WHEN division_by_zero THEN
      RAISE NOTICE 'caught';
  END;

  RETURN;
END;"""
        result = instrument(source, OID)

        # Verify we got tags for all major constructs
        tag_types = {t.tag_type for t in result.tags}
        assert TagType.BLOCK in tag_types
        assert TagType.BRANCH in tag_types
        assert TagType.LOOP in tag_types

        # Count specific patterns
        if_tags = [t for t in result.tags if t.description == "IF condition"]
        assert len(if_tags) == 5  # 3 top-level IFs + 2 nested inside FOR

        elsif_tags = [t for t in result.tags if t.description == "ELSIF condition"]
        assert len(elsif_tags) == 2

        else_tags = [t for t in result.tags if t.description == "ELSE branch"]
        assert len(else_tags) == 3  # IF-ELSE, IF-ELSIF-ELSE, nested IF-ELSE

        loop_tags = [t for t in result.tags if t.tag_type == TagType.LOOP]
        assert len(loop_tags) >= 3  # FOR, LOOP, WHILE

        ret_tags = [t for t in result.tags if "RETURN" in t.description]
        assert len(ret_tags) == 1

        # Verify source is still valid-looking (no broken syntax)
        lower_src = result.source.lower()
        assert lower_src.count("begin") >= 2  # outer + exception block
        assert "cover_me_cond(" in result.source
        assert "cover_me_branch(" in result.source
