# cover_me — Database Code Coverage

Code coverage for PostgreSQL PL/pgSQL and MySQL stored procedures and functions. Generates OpenCover XML reports and self-contained HTML reports.

Inspired by [piggly](https://github.com/kputnam/piggly) by kputnam — the original PL/pgSQL coverage tool written in Ruby.

## How It Works

cover_me instruments stored procedures and functions by injecting coverage tracking calls at branch, block, and loop points. When unit tests exercise the instrumented code, coverage hits are recorded. A report is then generated showing which lines and branches were executed.

```
trace → unit_test (external) → report → untrace
```

### Instrumentation

The instrumenter uses a regex-based tokeniser to identify control flow keywords (`IF`, `ELSE`, `WHILE`, `LOOP`, `FOR`, `CASE`, `RETURN`, `EXIT`, `CONTINUE`, `RAISE EXCEPTION`) and injects tracking calls at each point. Tag IDs are deterministic — `md5(oid:line:keyword)[:16]` — so the same source always produces the same tags.

| Construct          | Tag Type | What's Tracked                    |
| ------------------ | -------- | --------------------------------- |
| `BEGIN`            | Block    | Entry into block                  |
| `IF` / `ELSIF`     | Branch   | Condition true/false              |
| `ELSE`             | Branch   | Entry into else block             |
| `WHILE`            | Loop     | Condition true/false              |
| `FOR` / `LOOP`     | Loop     | Entry into loop body              |
| `EXIT` / `CONTINUE`| Branch   | Statement reached                 |
| `RETURN`           | Branch   | Statement reached                 |
| `RAISE EXCEPTION`  | Branch   | Statement reached                 |
| `EXCEPTION WHEN`   | Block    | Handler entered                   |

`CASE ... ELSE` inside expressions is correctly skipped — only statement-level `ELSE` (from `IF/ELSE`) is instrumented.

### Engine-Specific Behaviour

| Aspect              | Postgres                                    | MySQL                                        |
| -------------------- | ------------------------------------------- | -------------------------------------------- |
| Trace mechanism      | `RAISE WARNING` (survives ROLLBACK)         | `INSERT INTO cover_me.trace` (MyISAM — survives ROLLBACK) |
| Condition wrapper    | `cover_me_cond(tag, condition)` function    | `cover_me.cover_me_cond(tag, condition)` function |
| Branch tracker       | `PERFORM cover_me_branch(tag)`              | `INSERT INTO cover_me.trace (tag_id) VALUES (tag)` |
| Source query         | `pg_proc.prosrc`                            | `information_schema.ROUTINES.ROUTINE_DEFINITION` |
| Replace mechanism    | `CREATE OR REPLACE FUNCTION`                | `DROP` + `CREATE` (via cached `SHOW CREATE`) |
| Helper location      | `public` schema                             | `cover_me` database                          |
| Trace capture        | stderr file (`pg_prove ... 2> trace.txt`)   | MyISAM trace table (queried directly)        |
| DECLARE handling     | Injection after `BEGIN`                     | Injection after all `DECLARE` statements     |

## CLI Usage

```bash
cover_me <command> -E <engine> -H <host> -p <port> -d <dbname> -U <user> -W <password> [options]
```

### Commands

| Command   | Description                                          |
| --------- | ---------------------------------------------------- |
| `trace`   | Dump, instrument, and install functions               |
| `report`  | Parse trace data and generate OpenCover XML + HTML    |
| `untrace` | Restore original functions and remove helpers         |

### Options

| Flag              | Description                              | Default     |
| ----------------- | ---------------------------------------- | ----------- |
| `-E`, `--engine`  | Database engine (`postgres` or `mysql`)  | `postgres`  |
| `-H`, `--host`    | Database host                            | `localhost` |
| `-p`, `--port`    | Database port                            | auto (5432/3306) |
| `-d`, `--dbname`  | Database name                            | required    |
| `-U`, `--user`    | Database user                            | `root`      |
| `-W`, `--password`| Database password                        | empty       |
| `-c`, `--cache-dir`| Cache directory for original source     | `/coverage/cache` |
| `-f`, `--file`    | Trace file path (Postgres only)          | none        |
| `-o`, `--output`  | Output path for OpenCover XML            | `/coverage/opencover.xml` |

### Examples

```bash
# Postgres — full cycle
cover_me trace   -E postgres -H localhost -d mydb -U postgres -W secret
pg_prove --host localhost --dbname mydb ... 2> /coverage/trace.txt
cover_me report  -E postgres -H localhost -d mydb -U postgres -W secret -f /coverage/trace.txt
cover_me untrace -E postgres -H localhost -d mydb -U postgres -W secret

# MySQL — full cycle
cover_me trace   -E mysql -H localhost -p 3306 -d mydb -U root -W secret
my_prove -h localhost -u root -psecret -D tap --ext .sql -r /tests/
cover_me report  -E mysql -H localhost -p 3306 -d mydb -U root -W secret
cover_me untrace -E mysql -H localhost -p 3306 -d mydb -U root -W secret
```

## Standalone Usage

cover_me can be used independently of the docker compose pipeline. It only needs Python 3.12+ and a connection to your database.

### Install

```bash
pip install psycopg2-binary mysql-connector-python lxml
```

Or build the Docker image:

```bash
cd tools/cover_me
docker build -t cover_me .
```

### Postgres — Standalone

```bash
# 1. Instrument all PL/pgSQL functions
python -m cover_me.cli trace -E postgres -H localhost -d mydb -U postgres -W secret -c ./coverage/cache

# 2. Run your tests (any test runner — pg_prove, psql, your app, etc.)
#    Capture stderr which contains the RAISE WARNING trace output
pg_prove --host localhost --dbname mydb -r ./tests/ 2> ./coverage/trace.txt

# Or with psql:
psql -h localhost -d mydb -U postgres -f my_test.sql 2> ./coverage/trace.txt

# Or even run your application against the instrumented database — any code path
# that executes a function will generate coverage data

# 3. Generate the report
python -m cover_me.cli report -E postgres -H localhost -d mydb -U postgres -W secret \
    -c ./coverage/cache -f ./coverage/trace.txt -o ./coverage/opencover.xml

# 4. Restore original functions
python -m cover_me.cli untrace -E postgres -H localhost -d mydb -U postgres -W secret -c ./coverage/cache
```

### MySQL — Standalone

```bash
# 1. Instrument all stored procedures/functions
python -m cover_me.cli trace -E mysql -H localhost -p 3306 -d mydb -U root -W secret -c ./coverage/cache

# 2. Run your tests (any test runner — my_prove, mysql client, your app, etc.)
#    No file capture needed — hits are recorded in the cover_me.trace table (MyISAM)
my_prove -h localhost -u root -psecret -D tap --ext .sql -r ./tests/

# Or with the mysql client:
mysql -h localhost -u root -psecret < my_test.sql

# Or run your application — any code path that calls an instrumented function
# will record coverage hits in the trace table

# 3. Generate the report (reads from cover_me.trace table automatically)
python -m cover_me.cli report -E mysql -H localhost -p 3306 -d mydb -U root -W secret \
    -c ./coverage/cache -o ./coverage/opencover.xml

# 4. Restore original functions
python -m cover_me.cli untrace -E mysql -H localhost -p 3306 -d mydb -U root -W secret -c ./coverage/cache
```

### Docker — Standalone

```bash
# Postgres
docker run --rm --network host -v ./coverage:/coverage cover_me \
    trace -E postgres -H localhost -d mydb -U postgres -W secret

# MySQL
docker run --rm --network host -v ./coverage:/coverage cover_me \
    trace -E mysql -H localhost -p 3306 -d mydb -U root -W secret
```

### Key Points

- **Any test runner works** — cover_me doesn't care how the functions are exercised. Use pg_prove, my_prove, psql, mysql client, or your application.
- **Postgres trace capture** — the only requirement is redirecting stderr to a file (`2> trace.txt`) since `RAISE WARNING` outputs to stderr.
- **MySQL trace capture** — fully automatic. The MyISAM trace table records hits regardless of how the functions are called. No file capture needed.
- **Cache directory** — must be the same across `trace`, `report`, and `untrace` commands. It stores original function source for restoration.
- **Safe to run on shared databases** — `untrace` restores exact original definitions. However, instrumented functions have a small performance overhead, so avoid running on production.
- **CI/CD integration** — the OpenCover XML output (`opencover.xml`) is compatible with SonarQube, Azure DevOps, and ReportGenerator for integration into your build pipeline.

## Output

### OpenCover XML

`coverage/opencover.xml` — compatible with:
- [ReportGenerator](https://github.com/danielpalme/ReportGenerator)
- SonarQube
- Azure DevOps

OpenCover mapping:

| OpenCover Element | Maps To                    |
| ----------------- | -------------------------- |
| Module            | Schema / Database          |
| Class             | Schema.FunctionName        |
| Method            | The function itself        |
| SequencePoint     | Each instrumented point    |
| BranchPoint       | Each conditional (IF/WHILE)|

### HTML Report

`coverage/html/index.html` — self-contained, no external dependencies:
- Summary table with coverage bars per function
- Per-function drill-down with green (hit) / red (miss) line highlighting
- Sequence and branch coverage percentages

### Source Export

`coverage/source/<schema>/<name>.sql` — original function source files exported for ReportGenerator compatibility.

## Project Structure

```
cover_me/
├── Dockerfile
├── requirements.txt
├── cover_me/
│   ├── __init__.py
│   ├── cli.py                 # CLI entry point with --engine dispatch
│   ├── instrumenter.py        # Shared tokeniser, tag model, instrument()
│   ├── dumper.py              # Postgres: pg_proc query, ProcedureDef model, cache
│   ├── installer.py           # Postgres: CREATE OR REPLACE, RAISE WARNING helpers
│   ├── profile.py             # Shared: tag profile aggregation, trace file parser
│   ├── reporter.py            # Shared: OpenCover XML generation
│   ├── html_reporter.py       # Shared: HTML report generation
│   ├── pg/
│   │   └── __init__.py
│   └── mysql/
│       ├── __init__.py        # MySQL: information_schema query, dump_procedures()
│       ├── installer.py       # MySQL: MyISAM trace table, DROP+CREATE, SHOW CREATE cache
│       └── profile.py         # MySQL: trace table reader
└── tests/
    ├── test_instrumenter.py   # 37 tests — tokeniser + all control flow patterns
    ├── test_report.py         # 16 tests — profile, pattern matching, OpenCover XML
    ├── test_trace.py          # 12 tests — dumper, cache, installer SQL generation
    └── test_mysql.py          # 6 tests — MySQL-specific instrumentation
```

## Testing

```bash
cd tools/cover_me
pip install -r requirements.txt
python -m pytest tests/ -v
```

71 tests covering:
- Tokeniser (keyword detection, string/comment opacity, line numbers)
- All control flow patterns (IF, ELSIF, ELSE, WHILE, FOR, LOOP, EXIT, CONTINUE, RETURN, RAISE, CASE, EXCEPTION)
- Tag determinism (same input → same tags, different OID → different tags)
- Profile aggregation and trace file parsing
- OpenCover XML structure and coverage percentages
- MySQL-specific instrumentation (trace table inserts, DECLARE handling, CASE ELSE skipping)

## Dependencies

| Package                  | Purpose                    |
| ------------------------ | -------------------------- |
| `psycopg2-binary`       | PostgreSQL connection      |
| `mysql-connector-python` | MySQL connection           |
| `lxml`                   | XML processing             |
| `pytest`                 | Testing                    |
