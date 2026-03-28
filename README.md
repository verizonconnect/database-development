# database-development
Tooling for deploying, linting, testing and measuring code coverage of relational database code.

# Overview
The purpose of the tooling here is to provide a developer with a framework to develop, deploy, test and lint database code in isolation before submitting changes for a pull request. 

The code in this project serves mainly as an orchestrator and builds on the excellent work provided by many others.

| Name              | Github                                           | Comment                                          |
| ----------------- | ------------------------------------------------ | ------------------------------------------------ |
| flyway            | https://github.com/flyway/flyway-docker          | Database deployment tool                         |
| tSQLt             | https://github.com/tSQLt-org/tSQLt               | T-SQL unit test framework                        |
| PgTAP             | https://github.com/theory/pgtap                  | Postgres unit test framework                     |
| MyTAP             | https://github.com/hepabolu/mytap                | MySQL unit test framework                        |
| SQLServerCoverage | https://github.com/sayantandey/SQLServerCoverage | Generate TSQL Coverage Reports                   |
| cover_me          | (this repo)                                      | PL/pgSQL and MySQL code coverage (Python)        |
| piggly            | https://github.com/kputnam/piggly                | Original PL/pgSQL coverage tool (Ruby) by kputnam — basis for cover_me |
| sqlfluff          | https://github.com/sqlfluff/sqlfluff             | Linting and static code analysis                 |

Some sample Dockerfiles have been provided which have some of the tooling pre-installed before the test container is started. It would be expected that these images would reside on some internal registry for distribution within an organisation but for the purpose of allowing a working example to be provided some have been included here within the `/docker-buildfiles` folder. One for each engine is provided for in the samples.

A SQL/Database developer should not require any more knowledge than plain old SQL to make use of this. It has been designed to be easy for anyone with prior SQL knowledge to pick up and use with minimal fuss. 

# Pre-Requisites
Docker Desktop is required to run the samples.

# Installation
No installation is necessary.

# Samples

All three samples spin up a version of the Adventure Works database. Reference data is populated via repeatable flyway migrations. All other data required to satisfy unit tests is contained within the tests themselves.

## Pipeline

Each sample follows the same pipeline pattern, orchestrated via `docker compose`:

```
rules-generator → lint → database → flyway → [cover_trace] → unit_test → [cover_report] → [cover_untrace]
```

| Step            | Description                                                    |
| --------------- | -------------------------------------------------------------- |
| rules-generator | Generates `.sqlfluff` config from `coding_standard.yml`        |
| lint            | Runs sqlfluff with custom naming rules (non-blocking)          |
| database        | Starts the database engine container                           |
| flyway          | Deploys schemas, tables, constraints, functions, static data   |
| cover_trace     | Instruments stored procedures/functions for coverage tracking  |
| unit_test       | Runs TAP-based unit tests (tSQLt / pgTAP / MyTAP)             |
| cover_report    | Generates OpenCover XML and HTML coverage reports              |
| cover_untrace   | Restores original function definitions                         |

## MSSQL

```bash
cd ./samples/mssql
docker compose up
```

- 6 schemas, ~60 tables, stored procedures, triggers, views
- Unit testing via tSQLt
- Code coverage via SQLServerCoverage → OpenCover XML
- Linting via sqlfluff with custom naming plugin

Post-deployment review `./samples/mssql/coverage` and `./samples/mssql/lint`.

## Postgres

```bash
cd ./samples/pgsql
docker compose up
```

- 6 schemas, 68 tables, 14 PL/pgSQL functions
- Unit testing via pgTAP (2575+ assertions)
- Code coverage via cover_me → OpenCover XML + HTML
- Linting via sqlfluff with custom naming plugin
- Static reference data (address types, countries, currencies)

Post-deployment review `./samples/pgsql/coverage/html/index.html` and `./samples/pgsql/lint`.

## MySQL

```bash
cd ./samples/mysql
docker compose up
```

- 6 databases (common, human_resources, person, production, purchasing, sales), 68 tables, 14 stored functions/procedures
- Unit testing via MyTAP (216 assertions)
- Code coverage via cover_me → OpenCover XML + HTML
- Linting via sqlfluff with custom naming plugin

Post-deployment review `./samples/mysql/coverage/html/index.html` and `./samples/mysql/lint`.

## Clean up

```bash
docker compose down
```

# cover_me — Database Code Coverage Tool

`cover_me` is a Python tool that provides code coverage for PostgreSQL PL/pgSQL and MySQL stored procedures and functions. It generates OpenCover XML reports and self-contained HTML reports.

Located at `/docker-buildfiles/cover_me/`.

### Supported Engines

| Engine   | Trace Mechanism                          | Source Query                    |
| -------- | ---------------------------------------- | ------------------------------- |
| Postgres | `RAISE WARNING` (survives ROLLBACK)      | `pg_proc`                       |
| MySQL    | MyISAM trace table (survives ROLLBACK)   | `information_schema.ROUTINES`   |

### CLI Usage

```bash
# Postgres
cover_me trace   -E postgres -H host -d dbname -U user -W pass
cover_me report  -E postgres -H host -d dbname -U user -W pass -f trace.txt
cover_me untrace -E postgres -H host -d dbname -U user -W pass

# MySQL
cover_me trace   -E mysql -H host -p 3306 -d dbname -U user -W pass
cover_me report  -E mysql -H host -p 3306 -d dbname -U user -W pass
cover_me untrace -E mysql -H host -p 3306 -d dbname -U user -W pass
```

### How It Works

1. **trace** — Dumps function definitions, caches originals, installs helper functions, instruments each function with coverage tracking calls, replaces in database
2. **unit_test** (external) — Runs TAP tests which exercise the instrumented functions, generating coverage hits
3. **report** — Re-instruments cached source to regenerate deterministic tag IDs, reads coverage hits (file for Postgres, trace table for MySQL), generates OpenCover XML and HTML reports
4. **untrace** — Restores original function definitions from cache, removes helper functions

### Output

- `coverage/opencover.xml` — OpenCover XML compatible with ReportGenerator, SonarQube, Azure DevOps
- `coverage/html/index.html` — Self-contained HTML summary with per-function drill-down
- `coverage/source/` — Exported function source files

# Coding Standard

The coding standard is defined in YAML and used by the rules-generator to produce sqlfluff configuration. Each sample has its own `lint/coding_standard.yml` tailored to the dialect.

```yaml
Database Coding Standard:
    Scope:
        - SQL Server
        - MySQL
        - Postgres
Formatting:
    Tab or Space: Space
    Indentation: 4
    User Defined Object: snake_case
    Database Keyword Case: UPPER
    Database Function Case: UPPER
General Naming:
    Noun Singular or Pural Form: Singular
    Abbreviations Allowed: false
    Permitted Character Pattern: [a-zA-Z0-9_]
Naming:
    Table:          no prefix, singular nouns
    View:           vw_ prefix
    Primary Key:    pk_ prefix
    Check:          ck_ prefix
    Foreign Key:    fk_ prefix
    Index:          idx_ prefix
    Procedure:      verb_noun pattern (get_, set_, add_, delete_)
    Function:       verb_noun pattern (get_, set_, check_, validate_)
    Trigger:        tg_ prefix
    Column:         prime_modifier_class pattern (e.g. modified_utc_when)
```

See the full coding standard in the root `coding_standard.yml` or each sample's `lint/coding_standard.yml`.
