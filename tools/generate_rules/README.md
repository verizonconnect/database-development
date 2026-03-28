# generate_rules — Coding Standard → sqlfluff Config Generator

> ⚠️ **Work in Progress** — This tool is functional but under active development. Rule coverage is incomplete and the YAML schema may change.

Converts a human-readable `coding_standard.yml` file into a `.sqlfluff` configuration file. This allows coding standards to be defined once in plain YAML and enforced automatically via sqlfluff linting.

## Why

sqlfluff configuration is powerful but verbose and technical. A `coding_standard.yml` is easier for a team to read, review, and agree on. This tool bridges the gap — the team maintains the standard, the tool generates the linting config.

## How It Works

```
coding_standard.yml → generate_sqlfluff_rules.py → .sqlfluff
```

The generator reads the YAML, maps each section to the corresponding sqlfluff rules, and writes a `.sqlfluff` INI file. It runs as a Docker container in the pipeline before the lint step.

## Current Rule Support

| YAML Section                  | sqlfluff Rule(s)                    | Status      |
| ----------------------------- | ----------------------------------- | ----------- |
| Indentation                   | `layout.indent`                     | ✅ Working  |
| Keyword capitalisation        | `capitalisation.keywords`           | ✅ Working  |
| Function capitalisation       | `capitalisation.functions`          | ✅ Working  |
| Data type capitalisation      | `capitalisation.types`              | ✅ Working  |
| Literal capitalisation        | `capitalisation.literals`           | ✅ Working  |
| Identifier capitalisation     | `capitalisation.identifiers`        | ✅ Working  |
| Table naming                  | `custom.naming.table`               | ✅ Working  |
| View naming                   | `custom.naming.view`                | ✅ Working  |
| Procedure naming              | `custom.naming.procedure`           | ✅ Working  |
| Column naming (class pattern) | `custom.naming.column`              | ✅ Working  |
| Aliasing                      | `aliasing.table`, `aliasing.column` | ✅ Working  |
| Layout / spacing              | `layout.spacing`                    | ✅ Working  |
| Comma style (leading/trailing)| `layout.commas`                     | ⚠️ Disabled — incompatible with sqlfluff 3.4.x |
| Best practices                | Various                             | ✅ Partial  |
| Index naming                  | —                                   | ❌ Not yet  |
| Foreign key naming            | —                                   | ❌ Not yet  |
| Constraint naming             | —                                   | ❌ Not yet  |

## Usage

### In the Pipeline (docker compose)

The generator runs automatically as the `rules-generator` service:

```yaml
rules-generator:
    build: ../../tools/generate_rules
    command: ["-f", "/app/coding_standard.yml", "-o", "/src/.sqlfluff"]
    volumes:
        - ./lint/coding_standard.yml:/app/coding_standard.yml
        - ./src:/src
```

### Standalone

```bash
cd tools/generate_rules
pip install PyYAML
python generate_sqlfluff_rules.py -f /path/to/coding_standard.yml -o /path/to/.sqlfluff
```

### Docker

```bash
docker build -t generate_rules tools/generate_rules
docker run --rm \
    -v ./lint/coding_standard.yml:/app/coding_standard.yml \
    -v ./src:/src \
    generate_rules -f /app/coding_standard.yml -o /src/.sqlfluff
```

## Input Format

The `coding_standard.yml` follows a structured YAML schema. Each sample has its own version tailored to the dialect:

- `samples/mssql/lint/coding_standard.yml` — dialect: `tsql`
- `samples/pgsql/lint/coding_standard.yml` — dialect: `postgres`
- `samples/mysql/lint/coding_standard.yml` — dialect: `mysql`

Key sections:

```yaml
Database Coding Standard:
    Dialect: postgres                    # tsql | mysql | postgres

Formatting:
    Tab or Space: Space                  # Space | Tab
    Indentation: 4
    Capitalisation Policy:
        Database Keyword: upper          # upper | lower | consistent | capitalise
        Database Function: upper
        Data Type: upper
        User Defined Object: snake       # snake | camel | pascal | upper | lower

Naming:
    Table:
        Prefix: ''
    View:
        Prefix: 'vw'
    Primary Key Constraint:
        Prefix: 'pk'
    Column:
        Name Structure: '<prime>(_<modifier>)_<class>'
        Class: [id, status, name, when, date, num, ...]
```

See the full schema in any of the sample `coding_standard.yml` files.

## Output

A standard `.sqlfluff` INI file placed alongside the SQL source files:

```ini
[sqlfluff]
dialect = postgres
max_line_length = 100

[sqlfluff:indentation]
indent_unit = space
tab_space_size = 4

[sqlfluff:rules:capitalisation.keywords]
capitalisation_policy = upper

[sqlfluff:rules:custom.naming.table]
pattern = ^[a-z][a-z0-9_]+$
```

## Custom Naming Plugin

The generated config references custom naming rules (`custom.naming.*`) which are implemented in the companion `tools/sqlfluff_rules` plugin. Both tools must be used together — the generator produces the config, the plugin enforces the naming patterns.

## Known Limitations

- Comma style rule (`layout.commas`) is disabled due to incompatibility with sqlfluff 3.4.x
- Index, foreign key, and constraint naming rules are not yet generated
- The YAML schema is not formally validated — malformed input may produce unexpected config
- Column naming class/modifier patterns are complex and may need tuning per project
