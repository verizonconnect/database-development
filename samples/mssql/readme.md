# The Database Directory Structure
When used in the wild it would be expected that each database would reside in an individual repo. 
This is considered the root directory of a database for the purpose of a local build/deployment.
The folder structure is as follows

* /src: Contains the SQL files to be deployed to the database. More on the structure on this to follow..
* /test: Contains files related to the unit test framework and unit tests
* /coverage: Contains the code coverage report output
* /lint: Contains the lint report output
* .env: Properties which pertain to this repository/database. Users would be expected to edit this file.
* docker-compose.yml: Controls the build/deployment of the database

# .env
The variables here are the ones that would be expected to be set per database/environment by whatever tooling is used to control the deployments.
Any values set here are used for the 'local' builds only and should be tuned for faster build times. 

## The /src Folder Structure
It is the contents of the `/src` folder that will eventually be deployed.

In these sample projects Flyway is not being used as it was envisaged. For various reasons only repeatable files are used in the example here. Each object has it's own repeatable file and all scripts are written to be idempotent. The script deployment order is controlled using a strict naming convention to ensure dependencies are deployed in the correct order.

While this may seem to be at odds with everything you know about flyway there are some benefits to this approach.

* It allows developers to see the database stucture/objects from source. 
* There are fewer concerns of migration file conflicts. None actually since we do not use them.
* Before deployments the info command is clearer as to what objects are being impacted.
* During deployments it is clearer from the logs as to what action is being performed at a given time. 

## Flyway Repeatable File Naming Convention
Flway repeatable files are deployed alphabetically. This is not what we want for our projects so with some simple filename naming convention we can can control the deployment order. 

The repeatable files in this project follow this naming convention. 
`<repeatable prefix><primary sort order>.<secondary sort order>_(<schema name>)(.<object name>).sql`
Example
`r__40.00_foo.bar.sql`

The `40.00` above is not a file version. It is a deployment order precedence marker.

As flyway deploys all repeatable files alphabetically this allows us to control the exact order of the scripts so that schemas are deployed before tables, tables before views, views before procedures, and so on and so forth.

The secondary sort order allows us to control the deployment order within a category of object. This is usual where there are nested calls to functions/procedures.

All repeatable files of a given classification are contained within the same folder. I.e. All schema files reside in the same subfolder, all table files resides together in the same folder even if they are deployed to different schemas, etc.

Examples
| directory    | Filename                      | Comments                                           |
| ------------ | ----------------------------- | -------------------------------------------------- |
| 20_schema    | r__20.00_foo.sql              | The schema does not require the secondary sort order but we keep it for consistency |
| 40_table     | r__40.10_foo.bar.sql          | Tables typically do not require a secondary sort order but on some deployments we may want to do some specific pre-processing. This is rare but it can be accommodated |
| 40_table     | r__40.10_foo.cat.sql          | The same primary.secondary sort order can be used for any scripts where no dependencies exist at the primary sort order level |
| 50_procedure | r__50.00_foo.get_bar_plus.sql | This is a nested proc and we want to ensure it is deployed before the wrapper proc |
| 50_procedure | r__50.01_foo.get_bar.sql      | This proc calls foo.get_bar_plus so we want it to be deployed only when all dependencies exist |

In the trite examples above the schemas are deployed before tables, tables before procs and nested procs before wrapper procs.

Admittedly this is not a perfect system but it works for the vast majority of our deployments and allows for consistency across all codebases without having to consider any other flyway file types.

# Write Idempotent Code
All files should be written with an expectation that they will be re-executed at some stage.

Anything that support the `CREATE OR REPLACE/ALTER` statement should use that approach, i.e. functions/procedures/views/etc.

## Tables
Tables will be created once and schema modifications will be 
```
--SQL Server Example r__40.10_foo.fruit.sql
IF OBJECT_ID('[foo].[fruit]', 'U') IS NULL
BEGIN
    CREATE TABLE foo.fruit (
        [name]         VARCHAR(50)  NOT NULL
       ,[family]       VARCHAR(100) NOT NULL
       ,[created_date] DATETIME2(3) NOT NULL
    );
END;

--Some time later a new column is required
IF COLUMNPROPERTY(OBJECT_ID('[foo].[fruit]', 'U'), 'modified_date', 'ColumnId') IS NULL
BEGIN
    ALTER TABLE [foo].[fruit] 
    ADD [modified_date] DATETIME2(3) NULL;
END;

--Later again it was found the [family] column needs to be 
IF COLUMNPROPERTY(OBJECT_ID('[foo].[fruit]', 'U'), 'family', 'Precision') = 100
BEGIN
    ALTER TABLE [foo].[fruit] 
    ALTER COLUMN [family] VARCHAR(150) NOT NULL;
END;
GO
```

The "model" for what is expected resides in the unit tests. 
```
--
CREATE OR ALTER PROCEDURE test_schema_validation.test_foo_fruit__columns_match
AS
BEGIN
    CREATE TABLE [foo].[sales_reason_tsqlt](
        [name]          VARCHAR(50)  NOT NULL
       ,[family]        VARCHAR(150) NOT NULL
       ,[created_date]  DATETIME2(3) NOT NULL
       ,[modified_date] DATETIME2(3)     NULL
    );
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'foo.fruit_tsqlt'
                                      ,@Actual = N'foo.fruit'
                                      ,@Message = N'foo.fruit schema not as expected';
END;
GO
```
# /test
The test folder will contain all artefects required for executing unit tests.
The contents of this folder are only ever deployed to ephemeral databases. This is to ensure shared/production databases are not polluted with test objects and also to makes sure an improperly written test does not put production data at risk.

The structure of the test folder will vary greatly depending on the relational engine being used. 

More to come on this when Postgres/MySQL example are added.

# Naming Convention
In all samples here snake_case is used throughout for all database objects/columns. 
All keywords are in upper case.

There is more than just the two lines above but you get the gist. Take personal opinion out of it, this is just the standard being applied. It's a bit like 30km speed limits: No-one needs to like it, they just need to follow it.

# Guard Against Repeat Runs
Sometimes you just need to know it will not be run again.
This Repeatable file syntax will ensure the body is only executed once. 
Having this run as a post deployment script will ensure any dependecies exist before the script is executed as part of a build. A migration script could also be used but that then requires conditional logic to check for object dependencies. 
Up to you how you do it yourself.
```
--r__99.00_post_custom_data_update.sql
IF NOT EXISTS (SELECT   1 --Ensure BEGIN/END block is only executed once
               FROM     ${flyway:defaultSchema}.${flyway:table} AS ft
               WHERE    ft.[script] LIKE '%${flyway:filename}'
                        AND ft.[success] = 1)
    BEGIN
        --Your code here
    END;
```