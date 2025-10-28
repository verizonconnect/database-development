"""Custom rule bundle for custom checks."""

from functools import lru_cache
import re
from sqlfluff.core.rules import BaseRule, LintResult, RuleContext
from sqlfluff.core.rules.crawlers import SegmentSeekerCrawler


class Rule_Custom_CN03(BaseRule):
    """Column names must match a configured regex pattern."""

    name = "custom.naming.column"
    groups = ("all", "custom", "naming")
    config_keywords = ["pattern"]
    # We look for both CREATE and ALTER TABLE statements.
    crawl_behaviour = SegmentSeekerCrawler(
        {"create_table_statement", "alter_table_statement"}
    )

    def _eval(self, context: RuleContext) -> list[LintResult] | None:
        # self.logger.warning(f"Evaluating segment: {context.segment.raw[:50]}...")
        """Find column names and match them against the pattern."""
        if not hasattr(self, "pattern") or not self.pattern:
            return None
        pattern = compile_regex(self.pattern)

        violations = []

        # The context.segment will be either a create_table_statement
        # or an alter_table_statement.

        # 1. Handle CREATE TABLE statements
        if context.segment.is_type("create_table_statement"):
            # We need to find all the column definitions within the statement.
            for col_def in context.segment.recursive_crawl("column_definition"):
                # The column name is the first naked_identifier in the definition.
                col_name_segment = col_def.get_child("naked_identifier")
                if col_name_segment:
                    col_name = col_name_segment.raw
                    if not re.match(pattern, col_name):
                        violations.append(
                            LintResult(
                                anchor=col_name_segment,
                                description=(
                                    f"Column name '{col_name}' in CREATE TABLE "
                                    f"does not match configured pattern '{pattern.pattern}'."
                                ),
                            )
                        )

        # 2. Handle ALTER TABLE statements
        elif context.segment.is_type("alter_table_statement"):
            # In an ALTER statement, we look for "add column" clauses.
            for add_col_clause in context.segment.recursive_crawl("add_column_clause"):
                # The structure is similar: find the column definition.
                col_def = add_col_clause.get_child("column_definition")
                if col_def:
                    col_name_segment = col_def.get_child("naked_identifier")
                    if col_name_segment:
                        col_name = col_name_segment.raw
                        if not re.match(pattern, col_name):
                            violations.append(
                                LintResult(
                                    anchor=col_name_segment,
                                    description=(
                                        f"Column name '{col_name}' in ALTER TABLE "
                                        f"does not match configured pattern '{pattern.pattern}'."
                                    ),
                                )
                            )

        return violations or None

@lru_cache
def compile_regex(regex):
    return re.compile(regex)