# MySQL Sample

Adventure Works database on MySQL 8.4 with MyTAP unit testing, sqlfluff linting, and cover_me code coverage.

## Quick Start

```bash
docker compose up
```

## What Gets Deployed

- 6 databases: `common`, `human_resources`, `person`, `production`, `purchasing`, `sales`
- 68 tables with inline named primary keys
- 14 stored functions/procedures across `common`, `human_resources`, and `production`

Note: MySQL uses databases where Postgres/MSSQL use schemas. Cross-database foreign keys are not enforced.

## Pipeline

```
rules-generator → lint → mysql → flyway → function_deployer → cover_trace → tap_installer → unit_test → cover_report → cover_untrace
```

The `function_deployer` step is required because flyway OSS does not support `DELIMITER` for MySQL compound statements. Stored procedures/functions are deployed via the mysql client from the `functions/` directory.

## Outputs

| Output | Location |
| ------ | -------- |
| Lint report | `./lint/sqlfluff.output` |
| Coverage HTML | `./coverage/html/index.html` |
| Coverage XML | `./coverage/opencover.xml` |
| Function source | `./coverage/source/` |

## Test Summary

- 6 test files, 216 assertions via MyTAP
- Schema structure tests (tables, columns, engine per database)
- Functional tests for common schema functions

## Adapting to Your Database

To use this as a template for your own MySQL database, update the following files:

### 1. `.env` — Connection and naming

| Variable | Purpose | Change to |
| -------- | ------- | --------- |
| `database_name` | Flyway connection database | Usually `flyway` (leave as-is) |
| `user` | Database user | Your user |
| `password` | Database password | Your password |
| `host_port` | Port exposed to host | Any free port (default 3307 to avoid conflicts with local MySQL) |
| `container_name` | Docker container name | Unique name for your project |
| `default_schema` | Flyway history table database | Usually `flyway` (leave as-is) |

### 2. `init/000-init.sql` — Database creation

This script runs on first container start. Update it to create your databases:

```sql
CREATE DATABASE IF NOT EXISTS my_app;
CREATE DATABASE IF NOT EXISTS my_app_reporting;
```

### 3. `src/` — SQL source files (tables, constraints)

Replace the sample SQL files with your own:

| Directory | Content | Naming |
| --------- | ------- | ------ |
| `40_table/` | Tables | `r__40.09_<database>.<table>.sql` |
| `41_constraint_primary_key/` | Primary keys (if not inline) | `r__41.00_<database>.pk_<table>.sql` |
| `43_constraint_check/` | Check constraints | `r__43.00_<database>.ck_<constraint>.sql` |
| `45_constraint_foreign_key/` | Foreign keys (within same database) | `r__45.00_<database>.fk_<constraint>.sql` |

For MySQL, primary keys should be inline in the `CREATE TABLE` statement so InnoDB clusters correctly from the start.

### 4. `functions/` — Stored procedures and functions

Stored procedures with `BEGIN...END` blocks go here (not in `src/`). Each file uses `DELIMITER //` syntax:

```sql
DROP FUNCTION IF EXISTS my_app.my_function;

DELIMITER //

CREATE FUNCTION my_app.my_function (v_input INT)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN v_input * 2;
END//

DELIMITER ;
```

The `function_deployer` service deploys these via the mysql client.

### 5. `test/` — Unit tests

- One folder per database under `test/`
- Tests use MyTAP — `SELECT tap.ok(condition, description)` for functional tests
- Schema tests use `tap.has_table()`, `tap.columns_are()`, `tap.table_engine_is()`
- All test files start with `USE tap;` and `BEGIN;` / `ROLLBACK;`
- See [MyTAP documentation](https://github.com/hepabolu/mytap)

### 6. `lint/coding_standard.yml` — Linting rules

- Set `Dialect: mysql`
- Adjust naming patterns to match your team's standard
- The rules-generator converts this YAML into `.sqlfluff` config automatically

### 7. `docker-compose.yml` — Minimal changes

The compose file reads most configuration from `.env`. The only hardcoded value is the internal MySQL port (`3306`) used by cover_me services. This does not need changing unless you modify the MySQL container's internal port.
