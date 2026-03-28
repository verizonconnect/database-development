# Postgres Sample

Adventure Works database on PostgreSQL 13.4 with pgTAP unit testing, sqlfluff linting, and cover_me code coverage.

## Quick Start

```bash
docker compose up
```

## What Gets Deployed

- 6 schemas: `common`, `human_resources`, `person`, `production`, `purchasing`, `sales`
- 68 tables with primary keys, check constraints, and foreign keys
- 14 PL/pgSQL functions across `common`, `human_resources`, and `production` schemas
- Static reference data: address types, countries, currencies

## Pipeline

```
rules-generator → lint → postgres → flyway → cover_trace → unit_test → cover_report → cover_untrace
```

## Outputs

| Output | Location |
| ------ | -------- |
| Lint report | `./lint/sqlfluff.output` |
| Coverage HTML | `./coverage/html/index.html` |
| Coverage XML | `./coverage/opencover.xml` |
| Function source | `./coverage/source/` |

## Test Summary

- 75 test files, 2575+ assertions via pgTAP
- Schema structure tests (tables, columns, constraints per schema)
- Functional tests for all 14 stored functions

## Adapting to Your Database

To use this as a template for your own Postgres database, update the following files:

### 1. `.env` — Connection and naming

| Variable | Purpose | Change to |
| -------- | ------- | --------- |
| `database_name` | Postgres database name | Your database name |
| `user` | Database user | Your user |
| `password` | Database password | Your password |
| `host_port` | Port exposed to host | Any free port |
| `container_name` | Docker container name | Unique name for your project |
| `default_schema` | Flyway history table schema | Usually `flyway` (leave as-is) |

### 2. `init/` — Database initialisation

- `000-init.sql` — Creates the database. Update the database name to match `.env`.

### 3. `src/` — SQL source files

Replace the sample SQL files with your own, following the naming convention:

| Directory | Content | Naming |
| --------- | ------- | ------ |
| `20_schema/` | Schema creation | `r__20.00_<schema>.sql` |
| `22_user_defined_type/` | Custom types | `r__22.00_<schema>.<type>.sql` |
| `40_table/` | Tables | `r__40.09_<schema>.<table>.sql` |
| `41_constraint_primary_key/` | Primary keys | `r__41.00_<schema>.pk_<table>.sql` |
| `43_constraint_check/` | Check constraints | `r__43.00_<schema>.ck_<constraint>.sql` |
| `45_constraint_foreign_key/` | Foreign keys | `r__45.00_<schema>.fk_<constraint>.sql` |
| `60_function/` | Functions/procedures | `r__60.10_<schema>.<name>.sql` |
| `70_static_data/` | Reference data | `r__70.09_<schema>.<table>.sql` |

The numeric prefix controls deployment order. See the MSSQL readme for a detailed explanation of the naming convention.

### 4. `test/` — Unit tests

- One folder per schema under `test/`
- Test files: `function_<name>.sql`, `test_schema__<schema>.sql`, `table_<schema>.<table>.sql`
- Tests use pgTAP — see [pgTAP documentation](https://pgtap.org/documentation.html)

### 5. `lint/coding_standard.yml` — Linting rules

- Set `Dialect: postgres`
- Adjust naming patterns, capitalisation, and indentation to match your team's standard
- The rules-generator converts this YAML into `.sqlfluff` config automatically

### 6. `docker-compose.yml` — No changes needed

The compose file reads all configuration from `.env`. No hardcoded values to change.
