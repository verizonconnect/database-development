"""Custom rule bundle for custom checks."""

from functools import lru_cache
import re
from sqlfluff.core.rules import BaseRule, LintResult, RuleContext
from sqlfluff.core.rules.crawlers import SegmentSeekerCrawler

class Rule_Custom_CN04(BaseRule):
    """View name must match a configured regex pattern."""

    name = "custom.naming.table"
    groups = ("all", "custom", "naming")
    config_keywords = ["pattern"]
    # We are looking for the whole 'CREATE VIEW' statement. This works for
    # postgres, mysql, and tsql (sqlserver).
    crawl_behaviour = SegmentSeekerCrawler({"create_table_statement"})

    def _eval(self, context: RuleContext) -> LintResult | None:
        """Find view names and match them against the pattern."""
        if not hasattr(self, "pattern"):
            return None
        pattern = compile_regex(self.pattern)
        
        # The path to the name is very similar to procedures:
        # create_object_statement -> object_reference -> naked_identifier
        object_ref = context.segment.get_child("object_reference")
        if not object_ref:
            return None

        # The last naked_identifier is the view name.
        object_name_segment = object_ref.get_children("naked_identifier")[-1]

        if object_name_segment:
            object_name = object_name_segment.raw
            if not re.match(pattern, object_name):
                return LintResult(
                    anchor=object_name_segment,
                    description=(
                        f"Table name '{object_name}' does not match "
                        f"configured pattern '{pattern.pattern}'."
                    ),
                )
        return None


@lru_cache
def compile_regex(regex):
    """Compile a regex with case-insensitivity, caching the result."""
    return re.compile(regex)