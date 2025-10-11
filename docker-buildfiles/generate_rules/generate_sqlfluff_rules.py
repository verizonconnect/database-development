import yaml
import argparse
import configparser
import sys
from pathlib import Path
import re

def generate_comma_rule(config_data):
    """Generates the sqlfluff comma placement rule from the parsed YAML."""
    sql_rules = config_data.get('SQL', {})
    comma_rules = sql_rules.get('Commas', {})
    config = configparser.ConfigParser()
    enabled_rules = []

    comma_style = comma_rules['Trailing or Leading'].lower()
    if comma_style in ['trailing', 'leading']:
        config['sqlfluff:rules:layout.commas'] = {
            'comma_style': comma_style
        }
        enabled_rules.append('layout.commas')
    else:
        print(f"Warning: Invalid 'Trailing or Leading' value '{comma_style}'. Skipping comma rule.", file=sys.stderr)

    return config, enabled_rules

def generate_indentation_rule(config_data):
    """Generates the sqlfluff indentation rule from the parsed YAML."""
    formatting_rules = config_data.get('Formatting', {})
    
    # Strict checking: Ensure the indentation rules are explicitly defined in the YAML.
    try:
        indent_type = formatting_rules['Tab or Space'].lower()
        indent_size = formatting_rules['Indentation']
    except KeyError as e:
        print(f"Error: Missing required key in 'Formatting' section of YAML: {e}", file=sys.stderr)
        sys.exit(1)

    if indent_type not in ['space', 'tab']:
        print(f"Error: Invalid 'Tab or Space' value '{indent_type}'. Must be 'Space' or 'Tab'.", file=sys.stderr)
        sys.exit(1)

    config = configparser.ConfigParser()
    section_name = 'sqlfluff:rules:layout.indentation'
    config[section_name] = {
        'indent_unit': indent_type,
        'tab_space_size': str(indent_size)
    }
    
    return config, ['layout.indentation']

def generate_capitalisation_rules(config_data):
    """Generates the sqlfluff capitalisation rules from the parsed YAML."""
    formatting_rules = config_data.get('Formatting', {})
    config = configparser.ConfigParser()
    enabled_rules = []

    # Rule: Database Keyword Case (capitalisation.keywords)
    keyword_case = formatting_rules['Database Keyword Case'].lower()
    if keyword_case in ['upper', 'lower', 'capitalise', 'pascal', 'snake', 'camel']:
        config['sqlfluff:rules:capitalisation.keywords'] = {
            'capitalisation_policy': keyword_case
        }
        enabled_rules.append('capitalisation.keywords')

    # Rule: Database Function Case (capitalisation.functions)
    function_case = formatting_rules['Database Function Case'].lower()
    if function_case in ['upper', 'lower', 'capitalise', 'pascal', 'snake', 'camel', 'dash-case']:
        config['sqlfluff:rules:capitalisation.functions'] = {
            'capitalisation_policy': function_case
        }
        enabled_rules.append('capitalisation.functions')

    # Rule: User Defined Object Case (capitalisation.identifiers)
    identifier_case = formatting_rules['User Defined Object']
    allowed_cases = ['snake_case', 'camelCase', 'PascalCase', 'dash-case', 'lower', 'upper']
    if identifier_case in allowed_cases:
        config['sqlfluff:rules:capitalisation.identifiers'] = {
            'extended_capitalisation_policy': identifier_case
        }
        enabled_rules.append('capitalisation.identifiers')

    return config, enabled_rules

def generate_aliasing_rule(config_data):
    """Generates the sqlfluff aliasing rules from the parsed YAML."""
    sql_rules = config_data.get('SQL', {})
    config = configparser.ConfigParser()
    enabled_rules = []

    # Rule: Alias Using AS (aliasing.table and aliasing.column)
    alias_as = sql_rules['Alias Using AS'].lower()

    if alias_as in ['explicit', 'implicit']:
        # This rule applies to both table and column aliasing in sqlfluff
        config['sqlfluff:rules:aliasing.table'] = {
            'aliasing': alias_as
        }
        config['sqlfluff:rules:aliasing.column'] = {
            'aliasing': alias_as
        }
        # Add both aliasing rules to the list of enabled rules
        enabled_rules.extend(['aliasing.table', 'aliasing.column'])

    return config, enabled_rules

def generate_naming_rules(config_data):
    """Generates the convention.naming rules using regex patterns."""
    naming_rules = config_data.get('Naming', {})
    formatting_rules = config_data.get('Formatting', {})
    config = configparser.ConfigParser()
    enabled_rules = []

    # Map YAML object names to sqlfluff rule names for simple objects
    object_rule_map = {
        'Table': 'table',
        'View': 'view',
        'Sequence': 'sequence',
        'Primary Key Constraint': 'constraint.primary_key',
        'Check Constraint': 'constraint.check',
        'Foreign Key Constraint': 'constraint.foreign_key',
        'Unique Constraint': 'constraint.unique',
        'Default Constraint': 'constraint.default',
    }
    
    case_patterns = {
        'snake_case': '[a-z0-9_]+',
        'camelCase': '[a-z]+[a-zA-Z0-9]*',
        'PascalCase': '[A-Z][a-zA-Z0-9]*',
        'kebab-case': '[a-z0-9-]+',
        'UPPER': '[A-Z0-9_]+'
    }
    
    object_case_style = formatting_rules.get('User Defined Object')
    if not object_case_style or object_case_style not in case_patterns:
        print(f"Warning: 'User Defined Object' case style is missing or invalid in YAML. Skipping all naming convention rules.", file=sys.stderr)
        return config, enabled_rules

    object_pattern = case_patterns[object_case_style]

    # Handle simple naming conventions
    for object_name, rule_suffix in object_rule_map.items():
        if object_name in naming_rules:
            rule_details = naming_rules[object_name]
            structure = rule_details.get('Naming Structure')
            prefix = rule_details.get('Prefix')

            if structure:
                pattern = structure
                if isinstance(prefix, str):
                    pattern = pattern.replace('<prefix>', prefix)
                
                for placeholder in ['<object>', '<column>', '<parent_object>', '<leading column>']:
                    pattern = pattern.replace(placeholder, object_pattern)
                
                pattern = pattern.replace('(<id>)', '(_[0-9]+)?')
                pattern = pattern.replace('<id>', '[0-9]+')

                final_pattern = f"^{pattern}$"
                rule_name = f'convention.naming.{rule_suffix}'
                config[f'sqlfluff:rules:{rule_name}'] = {'pattern': final_pattern}
                enabled_rules.append(rule_name)

    # Handle complex "Index" naming convention
    if 'Index' in naming_rules:
        index_details = naming_rules['Index']
        index_structure = index_details.get('Naming Structure')
        prefixes_dict = index_details.get('Prefix', {})

        if index_structure and prefixes_dict:
            # Get unique prefixes from the dictionary values and create a regex OR group
            prefix_values = sorted(list(set(prefixes_dict.values())))
            prefix_pattern = f"({'|'.join(prefix_values)})"
            
            pattern = index_structure
            pattern = pattern.replace('<prefix>', prefix_pattern)
            pattern = pattern.replace('<object>', object_pattern)
            pattern = pattern.replace('<leading column>', object_pattern)
            pattern = pattern.replace('<id>', '[0-9]+')

            final_pattern = f"^{pattern}$"
            rule_name = 'convention.naming.index'
            config[f'sqlfluff:rules:{rule_name}'] = {'pattern': final_pattern}
            enabled_rules.append(rule_name)

    # Handle complex "Programmable Object" naming convention
    if 'Programmable Object' in naming_rules:
        po_details = naming_rules['Programmable Object']
        po_structure = po_details.get('Naming Structure')
        verbs_raw = [v.split('#')[0].strip() for v in po_details.get('Verb', [])]
        prefixes = po_details.get('Prefix', {})

        if po_structure and verbs_raw:
            # Transform verbs to match the required case style
            if object_case_style == 'PascalCase':
                verbs = [v.capitalize() for v in verbs_raw]
            elif object_case_style == 'UPPER':
                verbs = [v.upper() for v in verbs_raw]
            else: # snake_case and camelCase (for single words) are already lowercase
                verbs = verbs_raw

            verbs_pattern = f"({'|'.join(verbs)})"
            
            # Map the YAML sub-type to the sqlfluff rule name
            po_rule_map = {
                'Procedure': 'procedure',
                'Function': 'function',
                'Trigger': 'trigger'
            }

            for po_type, rule_suffix in po_rule_map.items():
                if po_type in prefixes:
                    prefix = prefixes[po_type]
                    
                    pattern = po_structure
                    pattern = pattern.replace('<prefix>', prefix)
                    pattern = pattern.replace('<verb>', verbs_pattern)
                    pattern = pattern.replace('<noun>', object_pattern)
                    pattern = pattern.replace('(__<optional>)', f'(__{object_pattern})?')

                    final_pattern = f"^{pattern}$"
                    rule_name = f'convention.naming.{rule_suffix}'
                    config[f'sqlfluff:rules:{rule_name}'] = {'pattern': final_pattern}
                    enabled_rules.append(rule_name)

    return config, enabled_rules

def generate_column_naming_rule(config_data):
    """Generates the convention.naming.column rule from the parsed YAML."""
    naming_rules = config_data.get('Naming', {})
    formatting_rules = config_data.get('Formatting', {})
    config = configparser.ConfigParser()
    enabled_rules = []

    if 'Column' not in naming_rules:
        return config, enabled_rules

    column_details = naming_rules['Column']
    classes_raw = list(column_details.get('Class', {}).keys())
    modifiers_dict = column_details.get('Modifier for Class', {})

    object_case_style = formatting_rules.get('User Defined Object')
    case_patterns = {
        'snake_case': '[a-z0-9_]+', 'camelCase': '[a-z]+[a-zA-Z0-9]*',
        'PascalCase': '[A-Z][a-zA-Z0-9]*', 'kebab-case': '[a-z0-9-]+', 'UPPER': '[A-Z0-9_]+'
    }
    
    if not classes_raw or not object_case_style in case_patterns:
        print("Warning: 'Column' naming section is incomplete. Skipping column naming rule.", file=sys.stderr)
        return config, enabled_rules

    prime_pattern = case_patterns[object_case_style]
    
    final_pattern_parts = []

    # Handle classes with defined modifiers
    for cls, mods_list in modifiers_dict.items():
        # FIX: The value from the updated YAML is a simple list of strings, not a list of dicts.
        modifiers_for_cls = mods_list if mods_list else []
        
        # Apply case transformation to the class and its modifiers
        if object_case_style == 'PascalCase':
            t_cls = cls.capitalize()
            t_mods = [m.capitalize() for m in modifiers_for_cls]
        elif object_case_style == 'UPPER':
            t_cls = cls.upper()
            t_mods = [m.upper() for m in modifiers_for_cls]
        else: # snake_case etc. are already lowercase
            t_cls = cls
            t_mods = modifiers_for_cls
        
        mods_pattern = f"({'|'.join(t_mods)})"
        # Create a regex part for this class that allows an optional modifier from its approved list
        # e.g., (_(utc|local))?_when
        final_pattern_parts.append(f"(_({mods_pattern}))?_{t_cls}")

    # Handle classes that have no defined modifiers
    classes_with_mods = modifiers_dict.keys()
    for cls in classes_raw:
        if cls not in classes_with_mods:
            if object_case_style == 'PascalCase':
                t_cls = cls.capitalize()
            elif object_case_style == 'UPPER':
                t_cls = cls.upper()
            else:
                t_cls = cls
            # Create a regex part for just the class
            # e.g., _id
            final_pattern_parts.append(f"_{t_cls}")

    # Combine all parts into a single group
    # e.g., ((_(utc|local))?_when|_(hour|day)?_total|_id)
    combined_endings = f"({'|'.join(final_pattern_parts)})"
    
    # Build the final regex: <prime><combined_endings>
    final_pattern = f"^{prime_pattern}{combined_endings}$"
    
    rule_name = 'convention.naming.column'
    config[f'sqlfluff:rules:{rule_name}'] = {'pattern': final_pattern}
    enabled_rules.append(rule_name)

    return config, enabled_rules


def main():
    """
    Main function to parse arguments, read the YAML file, and generate
    the sqlfluff configuration.
    """
    parser = argparse.ArgumentParser(description="Generate sqlfluff rules from a YAML coding standard.")
    parser.add_argument(
        "-f", "--file",
        default='cs.yml',
        help="Path to the coding standard YAML file. Defaults to 'cs.yml'."
    )
    parser.add_argument(
        "-o", "--output",
        default='-',
        help="Path for the output .sqlfluff file. Defaults to stdout (-)."
    )
    args = parser.parse_args()

    yaml_file = Path(args.file)
    if not yaml_file.is_file():
        print(f"Error: Coding standard file not found at '{yaml_file}'", file=sys.stderr)
        sys.exit(1)

    with open(yaml_file, 'r') as f:
        try:
            coding_standard = yaml.safe_load(f)
        except yaml.YAMLError as e:
            print(f"Error parsing YAML file: {e}", file=sys.stderr)
            sys.exit(1)

    database_standard = coding_standard.get('Database Coding Standard', {})
    dialect = database_standard.get('Dialect')

    if not dialect:
        print(f"Error: 'Dialect' not defined in the 'Database Coding Standard' section of '{yaml_file}'", file=sys.stderr)
        sys.exit(1)
        
    # --- Rule Generation ---
    indent_config, indent_rules = generate_indentation_rule(coding_standard)
    caps_config, caps_rules = generate_capitalisation_rules(coding_standard)
    alias_config, alias_rules = generate_aliasing_rule(coding_standard)
    comma_config, comma_rules = generate_comma_rule(coding_standard)
    naming_config, naming_rules = generate_naming_rules(coding_standard)
    column_naming_config, column_naming_rules = generate_column_naming_rule(coding_standard)
    
    all_rules = indent_rules + comma_rules + caps_rules + alias_rules + naming_rules + column_naming_rules

    # --- Final Config Assembly ---
    final_config = configparser.ConfigParser()

    final_config['sqlfluff'] = {
        'dialect': dialect,
        'templater': 'placeholder',
        'rules': ','.join(sorted(list(set(all_rules))))
    }

    final_config['sqlfluff:templater:placeholder'] = {
        'param_style': 'dollar',
        'flyway:defaultSchema': 'sch',
        'flyway:database': 'db',
        'database_name': 'db',
        'environment_name': 'build'
    }
    
    for config_obj in [indent_config, comma_config, caps_config, alias_config, naming_config, column_naming_config]:
        for section in config_obj.sections():
            final_config[section] = config_obj[section]

    # --- Output ---
    if args.output == '-':
        print(f"# Generated .sqlfluff configuration for dialect: {dialect}")
        print(f"# Based on standards from: {yaml_file}")
        print("# Save this content to a '.sqlfluff' file in your project root.")
        print("-" * 60)
        final_config.write(sys.stdout)
    else:
        output_path = Path(args.output)
        output_path.parent.mkdir(parents=True, exist_ok=True)
        with open(output_path, 'w') as configfile:
            final_config.write(configfile)
        print(f"Successfully generated rules to {output_path}", file=sys.stderr)


if __name__ == "__main__":
    main()

