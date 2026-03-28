"""Custom rule bundle for custom checks."""

from functools import lru_cache
import re
from sqlfluff.core.rules import BaseRule, LintResult, RuleContext
from sqlfluff.core.rules.crawlers import SegmentSeekerCrawler

class Rule_Custom_CN02(BaseRule):
    """View name must match a configured regex pattern."""

    name = "custom.naming.view"
    groups = ("all", "custom", "naming")
    config_keywords = ["pattern"]
    # We are looking for the whole 'CREATE VIEW' statement. This works for
    # postgres, mysql, and tsql (sqlserver).
    crawl_behaviour = SegmentSeekerCrawler({"create_view_statement"})

    def _eval(self, context: RuleContext) -> LintResult | None:
        """Find view names and match them against the pattern."""
        if not hasattr(self, "pattern"):
            return None
        pattern = compile_regex(self.pattern)
        
        # The path to the name is very similar to procedures:
        # create_view_statement -> object_reference -> naked_identifier
        view_ref = context.segment.get_child("object_reference")
        if not view_ref:
            return None

        # The last naked_identifier is the view name.
        view_name_segment = view_ref.get_children("naked_identifier")[-1]

        if view_name_segment:
            view_name = view_name_segment.raw
            if not re.match(pattern, view_name):
                return LintResult(
                    anchor=view_name_segment,
                    description=(
                        f"View name '{view_name}' does not match "
                        f"configured pattern '{pattern.pattern}'."
                    ),
                )
        return None


@lru_cache
def compile_regex(regex):
    """Compile a regex with case-insensitivity, caching the result."""
    return re.compile(regex)