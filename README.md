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

A SQL/Database developer should not require any more knowledge than plain old sql to make use of this. It has been designed to be easy for anyone with prior SQL knowledge to be easy to pick up and use with minimal fuss. 

# Pre-Requisites
Docker Desktop is required to run the samples.

# Installation
No installation is necessary.

### Example CLI Usage

Only MSSQL available right now. Postgres and MySQL to follow Jan 2024.

```bash
cd ./samples/mssql
docker compose up
```
