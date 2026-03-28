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
cd docker-buildfiles/cover_me
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
