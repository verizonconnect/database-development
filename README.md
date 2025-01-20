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

# Coding Standard
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
    Database Keyword: UPPER case
    Database Function: UPPER case
General Naming:
    Noun Singular or Pural Form: Singular
    Abbreviations Allowed: false
Naming:
    Object:
        Description: |
            An object refers to a table/view/constraint/sequence
        Prefix:
            Table: ''
            View: 'v_'
            Sequence: ''
            Constraint:
                Primary Key: 'pk_'
                Foreign Key: 'fk_'
                Check: 'ck_'
                Unique: 'uq_'
                Default: 'df_' #SQL Server Only
    Index:        
        Description: >
            Expand the prefix list where required for any extra index types, i.e. Spatial, Gist
        Prefix:
            Clustered: 'i_'
            Non-Clustered: 'i_'
            XML: 'x_'
            Column Store: 'cs_'
    Programmable Object:
        Naming Format: '(prefix_)<verb>_<noun>(__<optional>)'
        Description: |-
            Describes the structure of the programmable object.
            
            <prefix>: Some companies opt for a prefix such as fn_ or proc_ etc.
            <verb>: Will be from a list of approved verbs defined within this document
            <noun>: The entity upon which the function is primarily operating upon.
            __<optional>: Allows for extra text to be provided to ensure more clarity of purpose should the verb/noun pair be insufficient.
        Prefix:
            Procedure: ''
            Function: ''
            Trigger: 'tg_'
        Verb:
            - get #synonym for: Select/Read
            - set #synonym for: Update
            - add #synonym for: Insert/Create
            - delete #synonym for: Delete
        Function:
            Verb Extension: #Provide more verbs which are permitted for function naming
                - check
                - validate
        Procedure:
            Verb Extension: #Provide more verbs which are permitted for procedure naming
                - perform
    Column:
        Naming Format: '<prime>(_modifier)_<class>'
        Prime: |
            The prime element is user defined. E.g. customer, invoice, journey, etc
            A formal definition of available prime values is beyond the scope of this document.
        Class:
            ? id        # A unique identifier such as a column that is a primary key. 
            ? status    # Flag value or some other status of any type such as publication_status.
            ? total     # The fixed total or sum of a collection of values.
            ? num       # Denotes the field contains any kind of number.
            ? name      # Signifies a name such as first_name or country_name.
            ? seq       # Contains a contiguous sequence of values.
            ? when      # A temporal attribute. 
                        # A column records a row modification audit column which is required to be utc then the column name will be modified_utc_when
            ? date      # Denotes a column that contains the date ( as opposed to timestamp ).
            ? tally     # A count
            ? size      # The size of something such as a file size.
            ? addr      # An address for the record could be physical or intangible such as ip_addr.
            ? ind       # An indicator a boolean flag.
            ? desc      # Description. Used for string attributes when describing a noun in detail. 
            ? doc       # Document data such as json, html, xml, etc.
            ? code      # Can be a string or number, used to represent another in an indirect way. e.g. event_code
        Modifier:       # Define a list of approved modifiers for a given Class
            when:
                ? utc   # Timezone UTC
                ? local # Without timezone
            total:      # E.g. journey_hour_total
                ? second
                ? minute
                ? hour
                ? day
                ? week
                ? month
                ? year
                ? euro
                ? dollar
...

```
