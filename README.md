# database-development
Tooling for deploying, linting and testing relational database code

# Overview
The purpose of the tooling here is to provide a developer with a framework to develop, deploy, test and lint database code in isolation before submitting changes for a pull request. 

The code in this project serves mainly an orchestrator and builds on the excellent work provided by many others.

| Name              | Github                                           | Comment                                          |
| ----------------- | ------------------------------------------------ | ------------------------------------------------ |
| flyway            | https://github.com/flyway/flyway-docker          | Database deployment tool                         |
| tSQLt             | https://github.com/tSQLt-org/tSQLt               | T-SQL unit test framework                        |
| PgTAP             | https://github.com/theory/pgtap                  | Postgres unit test framework                     |
| MyTAP             | https://github.com/hepabolu/mytap                | MySQL unit test framework                        |
| SQLServerCoverage | https://github.com/sayantandey/SQLServerCoverage | Generate TSQL Coverage Reports                   |
| piggly            | https://github.com/kputnam/piggly                | Generate Postgres Coverage Reports (Coming Soon) |
| sqlfluff          | https://github.com/sqlfluff/sqlfluff             | Linting and static code analysis                 |


Some sample DockerFiles have been provided which have some of the tooling pre-installed before the test container is started. It would be expected that these images would reside on some internal registry for distribution within an organisation but for the purpose of allowing a working example to be provided some have been included here within the /docker-buildfiles folder. One for each engine is provided for in the samples.

A SQL/Database developer should not require any more knowledge than plain old sql to make use of this. It has been designed to be easy for anyone with prior SQL knowledge to to pick up and use with minimal fuss. 

# Pre-Requisites
Docker Desktop is required to run the samples.

# Installation
No installation is necessary.

### Example CLI Usage

Only MSSQL and Postgres available right now. MySQL to follow Apr 2024.

All examples will spin up a version of the adventure works database. It will remain largely devoid of data with only two or three tables populated to illustrate how reference data scripts can be treated having regard to the presence of foreign keys. With the exception of reference data all other data required to satisfy unit tests should be contained within the tests. 

As effort progresses on this repo more of the reference data will be added.

#### MSSQL

For MSSQL try...
```bash
cd ./samples/mssql
docker compose up
```

Post-deployment review the contents of `./samples/mssql/coverage` and `./samples/mssql/lint` respectively to view the outputs.

#### Postgres

For Postgres try...
```bash
cd ./samples/pgsql
docker compose up
```

Post-deployment review the contents of `./samples/pgsql/lint` to view the outputs. Piggy code coverage in the process of being added.

Clean up when done

```bash
docker compose down
```
