# Example plugin rules for sqlfluff

## Project Setup

Either the `pyproject.toml` or `setup.py` are required with the `entry_points` specified.

## Pip install

```sh
pip install sqlfluff
pip install path/to/sqlfluff-plugin-custom
sqlfluff lint sql_to_lint
```
```
== [sql_to_lint/test_procedure.sql] FAIL                                                                                                                                                                                                                                    
L:  11 | P:  22 | Custom_CN01 | Procedure name 'this_is_invalid' does not match
                       | configured pattern '^(get|set|add|del)_([A-Z0-9_]+)?$'.
                       | [custom.naming.procedure]
All Finished 📜 🎉!
```

## Docker

To run via docker:
```sh
docker build --no-cache -t my-sqlfluff-custom:latest .
docker run --rm -v "$(pwd)/sql_to_lint:/sqlfluff" my-sqlfluff-custom:latest lint .
```
```
== [test_procedure.sql] FAIL
L:  11 | P:  22 | Custom_CN01 | Procedure name 'this_is_invalid' does not match
                       | configured pattern
                       | 're.compile('^(get|set|add|del)_([A-Z0-9_]+)?$',
                       | re.IGNORECASE)'. [custom.naming.procedure]
All Finished!
```