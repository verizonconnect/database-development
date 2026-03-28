"""Custom rule bundle for custom checks."""
from typing import List, Type, Dict
from sqlfluff.core.plugin import hookimpl
from sqlfluff.core.rules import BaseRule, ConfigInfo

@hookimpl
def get_rules() -> List[Type[BaseRule]]:
    """Get plugin rules."""
    from sqlfluff_plugin_custom.CN01 import Rule_Custom_CN01
    from sqlfluff_plugin_custom.CN02 import Rule_Custom_CN02
    from sqlfluff_plugin_custom.CN03 import Rule_Custom_CN03
    from sqlfluff_plugin_custom.CN04 import Rule_Custom_CN04

    return [Rule_Custom_CN01
           ,Rule_Custom_CN02
           ,Rule_Custom_CN03
           ,Rule_Custom_CN04]

# This hook registers your custom configuration keywords with SQLFluff.
@hookimpl
def get_configs_info() -> Dict[str, ConfigInfo]:
    """Get rule config validations and descriptions."""
    return {
        "pattern": {
            "definition": "A regex pattern for custom names.",
        },
    }
