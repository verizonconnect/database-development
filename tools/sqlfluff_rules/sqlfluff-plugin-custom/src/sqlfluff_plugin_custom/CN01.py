"""Custom rule bundle for custom checks."""

from functools import lru_cache
import re
from sqlfluff.core.rules import BaseRule, LintResult, RuleContext
from sqlfluff.core.rules.crawlers import SegmentSeekerCrawler


class Rule_Custom_CN01(BaseRule):
    """Procedure name must match a configured regex pattern.

    **Anti-pattern**

    A procedure is created with a name that does not follow
    the agreed-upon convention.

    .. code-block:: sql

        -- The pattern is configured to '^PROC_.+$'
        CREATE PROCEDURE my_procedure()
        AS
        BEGIN
            SELECT 1;
        END;

    **Best practice**

    Follow the naming convention.

    .. code-block:: sql

        CREATE PROCEDURE PROC_DO_THE_THING()
        AS
        BEGIN
            SELECT 1;
        END;
    """

    name = "custom.naming.procedure"
    # Define this rule as part of the "naming" group within our "custom" bundle
    groups = ("all", "custom", "naming")
    # This keyword allows the rule to be configured from the .sqlfluff file
    config_keywords = ["pattern"]
    # We are looking for the whole 'CREATE PROCEDURE' OR 'ALTER PROCEDURE' statements.
    crawl_behaviour = SegmentSeekerCrawler(
        {"create_procedure_statement", "alter_procedure_statement"}
    )

    def _eval(self, context: RuleContext) -> LintResult | None:
        """Find procedure names and match them against the pattern."""

        if not hasattr(self, "pattern"):
            # No pattern is specified, skip
            self.logger.debug("Skipping because of no pattern is specified.")
            return None
        # TODO: skip if pattern is None or empty
        pattern = compile_regex(self.pattern)

        # The segment is the whole 'create_procedure_statement'.
        # We need to find the procedure name within it.
        # The path is create_procedure_statement -> procedure_reference -> object_reference -> naked_identifier
        self.logger.debug("Getting proc reference.")
        proc_ref = context.segment.get_child("object_reference")
        if not proc_ref:
            return None  # Should not happen in a valid CREATE PROCEDURE statement

        proc_name_segment = proc_ref.get_children("naked_identifier")[-1]

        if proc_name_segment:
            proc_name = proc_name_segment.raw

            # self.pattern is populated by the value from the .sqlfluff config
            # because we declared it in `config_keywords`.
            self.logger.debug("Match: %s", re.match(pattern, proc_name))
            if not re.match(pattern, proc_name):
                return LintResult(
                    anchor=proc_name_segment,
                    description=(
                        f"Procedure name '{proc_name}' does not match "
                        f"configured pattern '{pattern.pattern}'."
                    ),
                )
        return None

@lru_cache
def compile_regex(regex):
    return re.compile(regex)
