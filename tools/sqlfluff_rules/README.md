# sqlfluff_rules — Custom Naming Convention Plugin

> ⚠️ **Work in Progress** — Additional naming rules (index, constraint, trigger) are planned.

A custom [sqlfluff](https://github.com/sqlfluff/sqlfluff) plugin that enforces database object naming conventions via configurable regex patterns. This plugin is the enforcement counterpart to the [`generate_rules`](../generate_rules/) tool — the generator produces the `.sqlfluff` config, this plugin provides the rules that config references.

## Relationship with generate_rules

```
coding_standard.yml → generate_rules → .sqlfluff config
                                              ↓
                        SQL source files → sqlfluff + this plugin → lint results
```

1. The team defines naming conventions in `coding_standard.yml`
2. `generate_rules` converts those conventions into `.sqlfluff` config with `custom.naming.*` rule settings
3. sqlfluff loads this plugin which registers the `custom.naming.*` rules
4. sqlfluff lints the SQL files using the generated config + this plugin

Without this plugin, sqlfluff would not recognise the `custom.naming.*` rules in the config.

## Rules

| Rule ID      | Rule Name                  | Checks                                          |
| ------------ | -------------------------- | ------------------------------------------------ |
| `Custom_CN01`| `custom.naming.procedure`  | Stored procedure names match a regex pattern     |
| `Custom_CN02`| `custom.naming.view`       | View names match a regex pattern                 |
| `Custom_CN03`| `custom.naming.column`     | Column names match a regex pattern               |
| `Custom_CN04`| `custom.naming.table`      | Table names match a regex pattern                |

Each rule reads its `pattern` from the `.sqlfluff` config and validates the corresponding object names against it.

### Example Config

```ini
[sqlfluff:rules:custom.naming.table]
pattern = ^[a-z][a-z0-9_]+$

[sqlfluff:rules:custom.naming.view]
pattern = ^vw_[a-z][a-z0-9_]+$

[sqlfluff:rules:custom.naming.procedure]
pattern = ^(get|set|add|delete)_[a-z0-9_]+$

[sqlfluff:rules:custom.naming.column]
pattern = ^[a-z][a-z0-9_]+_(id|status|name|when|date|num|flag|desc|code)$
```

### Example Violations

```
L:7 | P:5 | Custom_CN03 | Column name 'orange_Juicy_num' in CREATE TABLE does not
                         | match configured pattern '^[a-z][a-z0-9_]+_(id|name|...)$'.

L:3 | P:1 | Custom_CN01 | Procedure name 'MyProc' does not match configured pattern
                         | '^(get|set|add|delete)_[a-z0-9_]+$'.
```

## Project Structure

```
sqlfluff_rules/
├── Dockerfile                          # Extends sqlfluff:3.4.2, installs plugin
├── sqlfluff-plugin-custom/
│   ├── pyproject.toml                  # Plugin metadata and entry point
│   ├── setup.py
│   └── src/sqlfluff_plugin_custom/
│       ├── __init__.py                 # Plugin hook — registers rules with sqlfluff
│       ├── CN01.py                     # custom.naming.procedure
│       ├── CN02.py                     # custom.naming.view
│       ├── CN03.py                     # custom.naming.column
│       └── CN04.py                     # custom.naming.table
└── sql_to_lint/                        # Test SQL files for manual validation
    ├── .sqlfluff
    ├── test_naming_columns.sql
    ├── test_naming_procedure.sql
    └── test_naming_view.sql
```

## Docker Image

The Dockerfile extends the official `sqlfluff/sqlfluff:3.4.2` image and installs the plugin:

```dockerfile
FROM sqlfluff/sqlfluff:3.4.2
COPY ./sqlfluff-plugin-custom /tmp/sqlfluff-plugin-custom
RUN pip install --no-cache-dir /tmp/sqlfluff-plugin-custom
```

This image is referenced as `${sqlfluff_image}` in each sample's `.env` and used by the `lint` service in docker compose.

## Standalone Usage

```bash
# Install sqlfluff and the plugin
pip install sqlfluff
pip install ./sqlfluff-plugin-custom

# Lint with a config that references custom.naming.* rules
sqlfluff lint --config .sqlfluff /path/to/sql/
```

## Adding New Rules

1. Create a new file `CN05.py` in `src/sqlfluff_plugin_custom/`
2. Implement a class extending `BaseRule` with a `name` like `custom.naming.index`
3. Register it in `__init__.py` by adding it to the `get_rules()` return list
4. Add the corresponding config key in `get_configs_info()` in `__init__.py`
5. Update `generate_rules` to emit the new rule's config from `coding_standard.yml`
