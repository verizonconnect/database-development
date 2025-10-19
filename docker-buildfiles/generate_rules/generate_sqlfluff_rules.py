# This was generated using a mix of AI and manual coding
import yaml
import argparse
import configparser
import sys
from pathlib import Path
import re

# As per sqlfluff docs, these are the only allowed values for capitalisation_policy
allowed_policies = ['consistent', 'upper', 'lower', 'pascal', 'capitalise', 'snake', 'camel']

# This dictionary serves as a global, reusable constant for regex patterns.
case_patterns = {
    'snake': '[a-z][a-z0-9_]+',
    'camel': '[a-z]+[a-zA-Z0-9]*',
    'pascal': '[A-Z][a-zA-Z0-9]*',
    'upper': '[A-Z][A-Z0-9_]+',
    'lower': '[a-z][a-z0-9_]+',
    'capitalise': '[A-Z][a-zA-Z0-9_]*'
}

# This maps the user-friendly names in the YAML to the official sqlfluff names.
# It now includes 'consistent' as a valid option.
yaml_to_sqlfluff_case_map = {
    'snake': 'snake_case',
    'camel': 'camelCase',
    'pascal': 'PascalCase',
    'upper': 'upper',
    'lower': 'lower',
    'capitalise': 'capitalise',
    'consistent': 'consistent'
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
        if keyword_case not in allowed_policies:
            print(f"Error: Invalid 'Database Keyword Case' value '{formatting_rules['Database Keyword Case']}'.", file=sys.stderr)
            print(f"Allowed values are: {allowed_policies}", file=sys.stderr)
            sys.exit(1)
        config['sqlfluff:rules:capitalisation.keywords'] = {'capitalisation_policy': keyword_case}
        enabled_rules.append('capitalisation.keywords')

        # Functions
        function_case = formatting_rules['Database Function Case'].lower()
        if function_case not in allowed_policies:
            print(f"Error: Invalid 'Database Function Case' value '{formatting_rules['Database Function Case']}'.", file=sys.stderr)
            print(f"Allowed values are: {allowed_policies}", file=sys.stderr)
            sys.exit(1)
        config['sqlfluff:rules:capitalisation.functions'] = {'capitalisation_policy': function_case}
        enabled_rules.append('capitalisation.functions')

        # Identifiers
        identifier_yaml_case = formatting_rules['User Defined Object']
        sqlfluff_identifier_case = yaml_to_sqlfluff_case_map.get(identifier_yaml_case)
        if not sqlfluff_identifier_case:
            print(f"Error: Invalid 'User Defined Object' value '{identifier_yaml_case}'.", file=sys.stderr)
            print(f"Allowed values are: {list(yaml_to_sqlfluff_case_map.keys())}", file=sys.stderr)
            sys.exit(1)
        
        if sqlfluff_identifier_case == 'consistent':
            config['sqlfluff:rules:capitalisation.identifiers'] = {'capitalisation_policy': sqlfluff_identifier_case}
        else:
            config['sqlfluff:rules:capitalisation.identifiers'] = {'extended_capitalisation_policy': sqlfluff_identifier_case}
        enabled_rules.append('capitalisation.identifiers')

        # Data Types
        datatype_case = formatting_rules['Data Type Case'].lower()
        if datatype_case not in allowed_policies:
            print(f"Error: Invalid 'Data Type Case' value '{formatting_rules['Data Type Case']}'.", file=sys.stderr)
            print(f"Allowed values are: {allowed_policies}", file=sys.stderr)
            sys.exit(1)
        config['sqlfluff:rules:capitalisation.datatypes'] = {'capitalisation_policy': datatype_case}
        enabled_rules.append('capitalisation.datatypes')
        
        # Literals
        literals_case = formatting_rules['Literals Case'].lower()
        if literals_case not in ['consistent', 'upper', 'lower', 'capitalise']:
            print(f"Error: Invalid 'Literals Case' value '{formatting_rules['Literals Case']}'.", file=sys.stderr)
            print(f"Allowed values are: 'consistent', 'upper', 'lower', 'capitalise'", file=sys.stderr)
            sys.exit(1)
        config['sqlfluff:rules:capitalisation.literals'] = {'capitalisation_policy': literals_case}
        enabled_rules.append('capitalisation.literals')

    except KeyError as e:
        print(f"Error: Missing required key in 'Formatting' section of YAML: {e}", file=sys.stderr)
        sys.exit(1)

    return config, enabled_rules

def generate_layout_rules(config_data):
    """Generates additional layout rules for spacing and line length."""
    formatting_rules = config_data.get('Formatting', {})
    layout_rules = formatting_rules.get('Layout', {})
    config = configparser.ConfigParser()
    enabled_rules = []

    if 'Max Line Length' in formatting_rules:
        max_len = formatting_rules['Max Line Length']
        config['sqlfluff:rules:layout.line_length'] = {'max_line_length': str(max_len)}
        enabled_rules.append('layout.line_length')
    
    if layout_rules.get('Spacing', {}).get('Around Operators'):
        enabled_rules.append('layout.spacing')

    if 'Blank Lines Between Statements' in layout_rules:
        enabled_rules.append('layout.gaps')
        
    return config, enabled_rules
    
def generate_best_practice_rules(config_data):
    """Generates rules that enforce SQL best practices."""
    sql_rules = config_data.get('SQL', {})
    config = configparser.ConfigParser()
    enabled_rules = []

    if not sql_rules.get('Allow Wildcards', True):
        enabled_rules.append('ambiguous.wildcard')

    quoting_policy = sql_rules.get('Identifier Quoting', 'when_needed').lower()
    if quoting_policy in ['quoted', 'unquoted']:
        config['sqlfluff:rules:convention.quoting'] = {'preferred_quoting_policy': quoting_policy}
        enabled_rules.append('convention.quoting')

    if not sql_rules.get('Allow Positional References', True):
        enabled_rules.append('references.positional')
        
    terminator_policy = sql_rules.get('Statement Terminator', 'required').lower()
    if terminator_policy == 'required':
        config['sqlfluff:rules:structure.terminator'] = {'require_final_semicolon': 'true'}
        enabled_rules.append('structure.terminator')
        
    return config, enabled_rules

def generate_aliasing_rule(config_data):
    """Generates the sqlfluff aliasing rules from the parsed YAML."""
    sql_rules = config_data.get('SQL', {})
    alias_rules = sql_rules.get('Alias', {})
    config = configparser.ConfigParser()
    enabled_rules = []
    
    try:
        table_alias_policy = alias_rules['Table Using AS'].lower()
        config['sqlfluff:rules:aliasing.table'] = {'aliasing': table_alias_policy}
        enabled_rules.append('aliasing.table')

        column_alias_policy = alias_rules['Column Using AS'].lower()
        config['sqlfluff:rules:aliasing.column'] = {'aliasing': column_alias_policy}
        enabled_rules.append('aliasing.column')

    except KeyError as e:
        print(f"Error: Missing required key in 'SQL' -> 'Alias' section of YAML: {e}", file=sys.stderr)
        sys.exit(1)
        
    return config, enabled_rules

def generate_comma_rule(config_data):
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
    """Generates the custom.naming. rules using regex patterns."""
    naming_rules = config_data.get('Naming', {})
    formatting_rules = config_data.get('Formatting', {})
    config = configparser.ConfigParser()
    enabled_rules = []

    object_rule_map = {
        'Table': 'table'
       ,'View': 'view'
       ,'Sequence': 'sequence'
       ,'Primary Key Constraint': 'primary_key'
       ,'Check Constraint': 'check'
       ,'Foreign Key Constraint': 'foreign_key'
       ,'Unique Constraint': 'unique'
       ,'Default Constraint': 'default'
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
                rule_name = f'custom.naming.{rule_suffix}'
                config[f'sqlfluff:rules:{rule_name}'] = {'pattern': f"^{pattern}$"}
                enabled_rules.append(rule_name)

    if 'Index' in naming_rules:
        details = naming_rules['Index']
        structure = details.get('Naming Structure')
        prefixes = details.get('Prefix', {})
        if structure and prefixes:
            prefix_pattern = f"({'|'.join(sorted(list(set(prefixes.values()))))})"
            pattern = structure.replace('<prefix>', prefix_pattern).replace('<object>', object_pattern).replace('<leading column>', object_pattern).replace('<id>', '[0-9]+')
            rule_name = 'custom.naming.index'
            config[f'sqlfluff:rules:{rule_name}'] = {'pattern': f"^{pattern}$"}
            enabled_rules.append(rule_name)

    if 'Programmable Object' in naming_rules:
        details = naming_rules['Programmable Object']
        structure_components = list(details.get('Structure Components', {'verb': None, 'noun': None}).keys())
        separator = details.get('Component Separator', '_')
        verbs_raw = list(details.get('Verb', {}).keys())
        prefixes = details.get('Prefix', {})

        if verbs_raw:
            verbs = verbs_raw
            if object_case_style in ['pascal', 'capitalise']: verbs = [v.capitalize() for v in verbs_raw]
            elif object_case_style == 'UPPER': verbs = [v.upper() for v in verbs_raw]

            verb_pattern = f"({'|'.join(verbs)})"
            component_patterns = {'verb': verb_pattern, 'noun': object_pattern}

            core_pattern_parts = [component_patterns[comp] for comp in structure_components if comp in component_patterns]
            core_pattern = f"{separator}".join(core_pattern_parts)
            optional_pattern = f'({separator}{object_pattern})?' if separator else f'({object_pattern})?'

            for po_type, rule_suffix in {'Procedure': 'procedure', 'Function': 'function', 'Trigger': 'trigger'}.items():
                if po_type in prefixes:
                    prefix = prefixes[po_type]
                    # FIX: Conditionally add the separator only if the prefix is not empty.
                    if prefix:
                        final_pattern = f"^{prefix}{separator}{core_pattern}{optional_pattern}$"
                    else:
                        final_pattern = f"^{core_pattern}{optional_pattern}$"

                    rule_name = f'custom.naming.{rule_suffix}'
                    config[f'sqlfluff:rules:{rule_name}'] = {'pattern': final_pattern}
                    enabled_rules.append(rule_name)

    return config, enabled_rules

def generate_column_naming_rule(config_data):
    """Generates the custom.naming.column rule from the parsed YAML."""
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
        if style == 'UPPER': return word.upper()
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
    rule_name = 'custom.naming.column'
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
        generate_indentation_rule,
        generate_capitalisation_rules,
        generate_aliasing_rule,
        generate_comma_rule,
        generate_naming_rules,
        generate_column_naming_rule,
        generate_layout_rules,
        generate_best_practice_rules,
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

