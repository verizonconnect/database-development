"""
Tests for MySQL-specific instrumentation.
"""
import pytest
from cover_me.instrumenter import instrument, TagType


OID = "99999"


class TestMySQLInstrumentation:

    def test_if_then_uses_trace_table(self):
        source = """BEGIN
  IF x > 0 THEN
    SET y = 1;
  END IF;
END"""
        result = instrument(source, OID, engine="mysql")
        assert "cover_me.trace" in result.source
        assert "cover_me.cover_me_cond(" in result.source
        assert "PERFORM" not in result.source  # no PG syntax

    def test_else_branch_uses_trace_table(self):
        source = """BEGIN
  IF x > 0 THEN
    SET y = 1;
  ELSE
    SET y = -1;
  END IF;
END"""
        result = instrument(source, OID, engine="mysql")
        assert "INSERT INTO cover_me.trace" in result.source

    def test_while_loop(self):
        source = """BEGIN
  WHILE n > 0 DO
    SET n = n - 1;
  END WHILE;
END"""
        result = instrument(source, OID, engine="mysql")
        assert "cover_me.cover_me_cond(" in result.source
        loop_tags = [t for t in result.tags if t.tag_type == TagType.LOOP]
        assert len(loop_tags) >= 1

    def test_return_instrumented(self):
        source = """BEGIN
  RETURN 42;
END"""
        result = instrument(source, OID, engine="mysql")
        assert "cover_me.trace" in result.source
        ret_tags = [t for t in result.tags if "RETURN" in t.description]
        assert len(ret_tags) == 1

    def test_case_else_not_instrumented(self):
        source = """BEGIN
  CASE x
    WHEN 1 THEN
      SET result = 'one';
    ELSE
      SET result = 'other';
  END CASE;
END"""
        result = instrument(source, OID, engine="mysql")
        else_tags = [t for t in result.tags if t.description == "ELSE branch"]
        assert len(else_tags) == 0

    def test_tags_same_as_postgres(self):
        """Same source should produce same tag IDs regardless of engine."""
        source = """BEGIN
  IF x > 0 THEN
    SET y = 1;
  END IF;
END"""
        pg_result = instrument(source, OID, engine="postgres")
        my_result = instrument(source, OID, engine="mysql")
        assert [t.id for t in pg_result.tags] == [t.id for t in my_result.tags]
