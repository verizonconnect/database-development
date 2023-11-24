# database-development
Tooling for deploying, linting and testing relational database code

# Overview
The purpose of the tooling here is to provide a developer with a framework to develop, deploy, test and lint database code in isolation before submitting changes for a pull request. It is aimed at developers in larger organisations which may re-use the same tooling and steps during a build phase and for deployment to shared databases.

This project is mainly an orchestrator which builds on the excellent work provided by many others.

| Name              | Github                                           | Comment                                          |
| ----------------- | ------------------------------------------------ | ------------------------------------------------ |
| docker            |                                                  | If you don't know then don't read any further    |
| flyway            | https://github.com/flyway/flyway-docker          | Database deployment                              |
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
No installation is necessary. All the tooling has been pre-installed on docker images or is managed within the docker compose file.

### Example CLI Usage

```bash
cd ./samples/mssql
docker compose up
```

# The Database Directory Structure
When used in the wild it would be expected that each database would reside in an individual repo. 
This is considered the root directory of a database for the purpose of a local build/deployment.
The folder structure is as follows

* /init: Contains the script used to create the database. Flyway does not create a database if one does not exist
* /coverage: Contains the code coverage reports
* /src: Contains the SQL files to be deployed to the database. More on the structure on this to follow..
* /test: Contains files related to the unit test framework and unit tests
* .env: Properties which pertain to this repository/database. Users would be expected to edit this file.
* docker-compose.yml: Controls the build/deployment of the database


## The /src Folder Structure
The deployment of the code is controlled using flyway and so users should refer to the flyway documentation for more details on how it operates.

In this project flyway is not being used as it was designed. For various reasons only repeatable files are used. Each object has it's own repeatable file and all scripts are written to be idempotent. The script deployment order is controlled using a strict naming convention to ensure dependencies are deployed in the correct order.

While this may seem to be at odds with everything you know about flyway there are some benefits to this. 

## Repeatable File Naming Convention
The repeatable files follow this naming convention. 
<repeatable prefix><primary sort order>.<secondary sort order>_(<schema name>)(.<object name>).sql
As flyway deploys all repeatable files alphabetically this allows us to control the exact order of the scripts so that schemas are deployed before tables, tables before procedures, etc.

The secondary sort order allows us to control the deployment order within a category of object. This is usual where there are nested calls to functions/procedures.

All repeatable files of a given classification are contained within the same folder. I.e. All schema files reside in the same subfolder, all table files resides together in the same folder even if they are deployed to different schemas, etc.

Examples
/20_schema/r__20.00_foo.sql "<repeatable prefix = r__><primary sort order = 20>.<secondary sort order = 00>_<schema name = foo>.sql"
/40_table/r__40.00_foo.bar.sql "<repeatable prefix = r__><primary sort order = 40>.<secondary sort order = 00>_<schema name = foo>.<table name = bar>.sql"
/50_procedure/r__50.00_foo.get_user_address.sql "<repeatable prefix = r__><primary sort order = 50>.<secondary sort order = 00>_<schema name = foo>.<proc name = get_user_address>.sql"
/50_procedure/r__50.01_foo.get_user.sql "<repeatable prefix = r__><primary sort order = 50>.<secondary sort order = 01>_<schema name = foo>.<proc name = get_user>.sql"

Admittedly this is not a perfect system but it works for the vast majority of our deployments and allows for consistency across all codebases.

### Concurrent development
As there are no migration scripts there is no risk of migration script version conflicts occurring on the more active database repositories. The chances of a developer working on the same object at the same time is less likely than two developers working on any database change at the same time.

### Object Visibility in Source
As each of the objects is contained within a repeatable file it is easier for developers to see at a glance how many objects of a certain type exist without having to sping up the database and query the metadata.


