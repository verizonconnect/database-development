# This was generated using a mix of AI and manual coding
import yaml
import argparse
import configparser
import sys
from pathlib import Path
import re

# ... (previous functions like generate_indentation_rule, etc., remain the same)
case_patterns = {
    'snake': '[a-z0-9_]+'
   ,'camel': '[a-z]+[a-zA-Z0-9]*'
   ,'pascal': '[A-Z][a-zA-Z0-9]*'
   ,'UPPER': '[A-Z0-9_]+'
   ,'lower': '[a-z0-9_]+'
}

def generate_indentation_rule(config_data):
    """Generates the sqlfluff indentation rule from the parsed YAML."""
    formatting_rules = config_data.get('Formatting', {})

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
    config['sqlfluff:rules:layout.indentation'] = {
        'indent_unit': indent_type,
        'tab_space_size': str(indent_size)
    }
    return config, ['layout.indentation']

def generate_capitalisation_rules(config_data):
    """Generates all sqlfluff capitalisation rules from the parsed YAML."""
    formatting_rules = config_data.get('Formatting', {})
    config = configparser.ConfigParser()
    enabled_rules = []

    try:
        # Keywords
        keyword_case = formatting_rules['Database Keyword Case'].lower()
        config['sqlfluff:rules:capitalisation.keywords'] = {'capitalisation_policy': keyword_case}
        enabled_rules.append('capitalisation.keywords')

        # Functions
        function_case = formatting_rules['Database Function Case'].lower()
        config['sqlfluff:rules:capitalisation.functions'] = {'capitalisation_policy': function_case}
        enabled_rules.append('capitalisation.functions')

        # Identifiers
        identifier_case = formatting_rules['User Defined Object']
        config['sqlfluff:rules:capitalisation.identifiers'] = {'extended_capitalisation_policy': identifier_case}
        enabled_rules.append('capitalisation.identifiers')

        # Data Types
        datatype_case = formatting_rules['Data Type Case'].lower()
        config['sqlfluff:rules:capitalisation.datatypes'] = {'capitalisation_policy': datatype_case}
        enabled_rules.append('capitalisation.datatypes')

    except KeyError as e:
        print(f"Error: Missing required key in 'Formatting' section of YAML: {e}", file=sys.stderr)
        sys.exit(1)

    return config, enabled_rules

def generate_layout_rules(config_data):
    """Generates additional layout rules for spacing and line length."""
    formatting_rules = config_data.get('Formatting', {})
    layout_rules = config_data.get('Layout', {})
    config = configparser.ConfigParser()
    enabled_rules = []

    # Max Line Length
    if 'Max Line Length' in formatting_rules:
        max_len = formatting_rules['Max Line Length']
        config['sqlfluff:rules:layout.line_length'] = {'max_line_length': str(max_len)}
        enabled_rules.append('layout.line_length')
    
    # Spacing
    spacing = layout_rules.get('Spacing', {})
    if spacing.get('Around Operators'):
        enabled_rules.append('layout.spacing')

    # Gaps
    if 'Blank Lines Between Statements' in layout_rules:
        # This rule in sqlfluff is about *not* having gaps within statements,
        # but enabling it helps enforce consistent grouping.
        enabled_rules.append('layout.gaps')
        
    return config, enabled_rules
    
def generate_best_practice_rules(config_data):
    """Generates rules that enforce SQL best practices."""
    sql_rules = config_data.get('SQL', {})
    config = configparser.ConfigParser()
    enabled_rules = []

    # Disallow SELECT *
    if not sql_rules.get('Allow Wildcards', True):
        enabled_rules.append('ambiguous.wildcard')

    # Identifier Quoting
    quoting_policy = sql_rules['Identifier Quoting'].lower()
    if quoting_policy in ['quoted', 'unquoted']:
        config['sqlfluff:rules:convention.quoting'] = {
            'preferred_quoting_policy': quoting_policy
        }
        enabled_rules.append('convention.quoting')

    # Disallow Positional ORDER BY
    if not sql_rules.get('Allow Positional References', True):
        enabled_rules.append('references.positional')
        
    # Statement Terminators
    terminator_policy = sql_rules['Statement Terminator'].lower()
    if terminator_policy in ['required', 'optional']:
        config['sqlfluff:rules:structure.terminator'] = {
            'require_final_semicolon': 'true'
        }
        enabled_rules.append('structure.terminator')
        
    return config, enabled_rules


# ... (previous functions for aliasing, commas, and naming conventions remain here)
def generate_aliasing_rule(config_data):
    """Generates the sqlfluff aliasing rules from the parsed YAML."""
    sql_rules = config_data.get('SQL', {})
    config = configparser.ConfigParser()
    enabled_rules = []
    try:
        alias_as = sql_rules['Alias Using AS'].lower()
        config['sqlfluff:rules:aliasing.table'] = {'aliasing': alias_as}
        config['sqlfluff:rules:aliasing.column'] = {'aliasing': alias_as}
        enabled_rules.extend(['aliasing.table', 'aliasing.column'])
    except KeyError as e:
        print(f"Error: Missing required key in 'SQL' section of YAML: {e}", file=sys.stderr)
        sys.exit(1)
    return config, enabled_rules

def generate_comma_rule(config_data):
    """Generates the sqlfluff comma placement rule from the parsed YAML."""
    sql_rules = config_data.get('SQL', {})
    config = configparser.ConfigParser()
    enabled_rules = []
    try:
        comma_style = sql_rules['Commas']['Trailing or Leading'].lower()
        config['sqlfluff:rules:layout.commas'] = {'comma_style': comma_style}
        enabled_rules.append('layout.commas')
    except KeyError as e:
        print(f"Error: Missing required key in 'SQL' -> 'Commas' section of YAML: {e}", file=sys.stderr)
        sys.exit(1)
    return config, enabled_rules

def generate_naming_rules(config_data):
    """Generates the convention.naming rules using regex patterns."""
    naming_rules = config_data.get('Naming', {})
    formatting_rules = config_data.get('Formatting', {})
    config = configparser.ConfigParser()
    enabled_rules = []

    object_rule_map = {
        'Table': 'table'
       ,'View': 'view'
       ,'Sequence': 'sequence'
       ,'Primary Key Constraint': 'constraint.primary_key'
       ,'Check Constraint': 'constraint.check'
       ,'Foreign Key Constraint': 'constraint.foreign_key'
       ,'Unique Constraint': 'constraint.unique'
       ,'Default Constraint': 'constraint.default'
    }

    object_case_style = formatting_rules.get('User Defined Object')
    if not object_case_style or object_case_style not in case_patterns:
        print("Error: 'User Defined Object' case style is missing or invalid in YAML.", file=sys.stderr)
        sys.exit(1)
    object_pattern = case_patterns[object_case_style]

    for object_name, rule_suffix in object_rule_map.items():
        if object_name in naming_rules:
            details = naming_rules[object_name]
            structure = details.get('Naming Structure')
            prefix = details.get('Prefix')
            if structure:
                pattern = structure
                if isinstance(prefix, str): pattern = pattern.replace('<prefix>', prefix)
                for ph in ['<object>', '<column>', '<parent_object>', '<leading column>']: pattern = pattern.replace(ph, object_pattern)
                pattern = pattern.replace('(<id>)', '(_[0-9]+)?').replace('<id>', '[0-9]+')
                rule_name = f'convention.naming.{rule_suffix}'
                config[f'sqlfluff:rules:{rule_name}'] = {'pattern': f"^{pattern}$"}
                enabled_rules.append(rule_name)

    if 'Index' in naming_rules:
        details = naming_rules['Index']
        structure = details.get('Naming Structure')
        prefixes = details.get('Prefix', {})
        if structure and prefixes:
            prefix_pattern = f"({'|'.join(sorted(list(set(prefixes.values()))))})"
            pattern = structure.replace('<prefix>', prefix_pattern).replace('<object>', object_pattern).replace('<leading column>', object_pattern).replace('<id>', '[0-9]+')
            rule_name = 'convention.naming.index'
            config[f'sqlfluff:rules:{rule_name}'] = {'pattern': f"^{pattern}$"}
            enabled_rules.append(rule_name)

    if 'Programmable Object' in naming_rules:
        details = naming_rules['Programmable Object']
        structure = details.get('Naming Structure')
        verbs_raw = [v.split('#')[0].strip() for v in details.get('Verb', [])]
        prefixes = details.get('Prefix', {})
        if structure and verbs_raw:
            verbs = verbs_raw
            if object_case_style == 'pascal': verbs = [v.capitalize() for v in verbs_raw]
            elif object_case_style == 'upper': verbs = [v.upper() for v in verbs_raw]
            verbs_pattern = f"({'|'.join(verbs)})"
            for po_type, rule_suffix in {'Procedure': 'procedure', 'Function': 'function', 'Trigger': 'trigger'}.items():
                if po_type in prefixes:
                    prefix = prefixes[po_type]
                    pattern = structure.replace('<prefix>', prefix).replace('<verb>', verbs_pattern).replace('<noun>', object_pattern).replace('(__<optional>)', f'(__{object_pattern})?')
                    rule_name = f'convention.naming.{rule_suffix}'
                    config[f'sqlfluff:rules:{rule_name}'] = {'pattern': f"^{pattern}$"}
                    enabled_rules.append(rule_name)
    return config, enabled_rules

def generate_column_naming_rule(config_data):
    """Generates the convention.naming.column rule from the parsed YAML."""
    naming_rules = config_data.get('Naming', {})
    formatting_rules = config_data.get('Formatting', {})
    config = configparser.ConfigParser()
    enabled_rules = []

    if 'Column' not in naming_rules: return config, enabled_rules
    column_details = naming_rules['Column']
    classes_raw = list(column_details.get('Class', {}).keys())
    modifiers_dict = column_details.get('Modifier for Class', {})
    object_case_style = formatting_rules.get('User Defined Object')

    if not classes_raw or not object_case_style in case_patterns:
        print("Warning: 'Column' naming section is incomplete. Skipping rule.", file=sys.stderr)
        return config, enabled_rules
    prime_pattern = case_patterns[object_case_style]
    final_pattern_parts = []
    
    def transform_case(word, style):
        if style == 'pascal': return word.capitalize()
        if style == 'upper': return word.upper()
        return word

    for cls, mods_list in modifiers_dict.items():
        mods_for_cls = mods_list if mods_list else []
        t_cls = transform_case(cls, object_case_style)
        t_mods = [transform_case(m, object_case_style) for m in mods_for_cls]
        mods_pattern = f"({'|'.join(t_mods)})"
        final_pattern_parts.append(f"(_({mods_pattern}))?_{t_cls}")

    classes_with_mods = modifiers_dict.keys()
    for cls in classes_raw:
        if cls not in classes_with_mods:
            t_cls = transform_case(cls, object_case_style)
            final_pattern_parts.append(f"_{t_cls}")

    combined_endings = f"({'|'.join(final_pattern_parts)})"
    final_pattern = f"^{prime_pattern}{combined_endings}$"
    rule_name = 'convention.naming.column'
    config[f'sqlfluff:rules:{rule_name}'] = {'pattern': final_pattern}
    enabled_rules.append(rule_name)
    return config, enabled_rules

def main():
    """Main function to parse arguments, read YAML, and generate config."""
    parser = argparse.ArgumentParser(description="Generate sqlfluff rules from a YAML coding standard.")
    parser.add_argument("-f", "--file", default='cs.yml', help="Path to the YAML file.")
    parser.add_argument("-o", "--output", default='-', help="Path for the output .sqlfluff file. Defaults to stdout (-).")
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
        print(f"Error: 'Dialect' not defined in the 'Database Coding Standard' section.", file=sys.stderr)
        sys.exit(1)
        
    rule_generators = [
        generate_indentation_rule
       ,generate_capitalisation_rules
       ,generate_aliasing_rule
       ,generate_comma_rule
       ,generate_naming_rules
       ,generate_column_naming_rule
       ,generate_layout_rules
       ,generate_best_practice_rules
    ]
    
    all_configs = []
    all_rules = []
    for generator in rule_generators:
        config_obj, rules_list = generator(coding_standard)
        all_configs.append(config_obj)
        all_rules.extend(rules_list)

    final_config = configparser.ConfigParser()
    final_config['sqlfluff'] = {
        'dialect': dialect,
        'templater': 'placeholder',
        'rules': ','.join(sorted(list(set(all_rules))))
    }
    final_config['sqlfluff:templater:placeholder'] = {
        'param_style': 'dollar'
       ,'flyway:defaultSchema': 'sch'
       ,'flyway:database': 'db'
       ,'database_name': 'db'
       ,'environment_name': 'build'
    }
    
    for config_obj in all_configs:
        for section in config_obj.sections():
            final_config[section] = config_obj[section]

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

