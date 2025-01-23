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
    Examples: |
        Hitting <Tab> will insert 4 spaces.
            Example of newline then <tab>
        
        Database name according the convention
            adventure_works
        
        Sample keyword casing
            SELECT  MIN(t.c)
            FROM    sample.coding_standard AS t;
General Naming:
    Noun Singular or Pural Form: Singular
    Abbreviations Allowed: false
    Permitted Character Pattern: [a-zA-Z0-9_]
Naming:
    Table:
        Naming Structure: 'prefix_<object>'
        Prefix: ''
    View:
        Naming Structure: 'prefix_<object>'
        Prefix: 'vw'
    Sequence:
        Naming Structure: 'prefix_<object>'
        Prefix: 'sq'
    Primary Key Constraint:
        Naming Structure: 'prefix_<object>'
        Prefix: 'pk'
    Check Constraint:
        Naming Structure: 'prefix_<object>__<column>'
        Prefix: 'ck'
    Foreign Key Constraint:
        Naming Structure: 'prefix_<object>__<parent_object>(_<id>)'
        Prefix: 'fk'
        Description: >
            <prefix>: As defined for the object type.
            <object>: The table on which the foreign key will be created.
            <parent_object>: The owning table of the foreign key.
            <id>: An optional incrementing integer value used to uniquely identify the constraint if multiple foreign keys are present where the <object> and <parent_object> are the same.
    Unique Constraint:
        Naming Structure: 'prefix_<object>__<leading column>_<id>'
        Prefix: 'uq'
        Description: >
            <prefix>: As defined for the object type.
            <object>: The table upon which the unique constraint will be created.
            <leading column>: The leading sort column of the constraint. This is usually the most important column of the underlying index created to implement the constraint.
            <id>: An incrementing integer value used to uniquely identify the constraint. Useful if the leading column happens to be present on multiple unique constraints on a given table. 
    Default Constraint:
        Naming Structure: 'prefix_<object>__<column>'
        Prefix: 'df'
        Description: >
            This applies to SQL Server Only.
            
            <prefix>: As defined for the object type.
            <object>: The table upon which the default constraint will be created.
            < olumn>: The column for which the constraint applies
    Index:
        Naming Structure: 'prefix_<object>__<leading column>_<id>'
        Description: >
            <prefix>: From one of the predefined prefixes permitted for an index.
            <object>: The table or view upon which the index is derived.
            <leading column>: The leading sort column of the index. This is usually the most important column of the index.
            <id>: An incrementing integer value used to uniquely identify the index. Useful if the leading column happens to be present on multiple indexes on a given table. 
            
            Examples: idx_department__name_3
                      xml_product_model__catalog_description_1
            
            Expand the prefix list where required for any extra index types, i.e. Spatial, Gist
        Prefix:
            Clustered: 'idx'
            Non-Clustered: 'idx'
            XML: 'xml_'
            Column Store: 'cs'
    Programmable Object:
        Naming Structure: '(prefix_)<verb>_<noun>(__<optional>)'
        Description: |-
            Describes the structure of the programmable object.
            
            <prefix>: Optional. Some companies opt for a prefix such as fn_ or proc_ etc.
            <verb>: Will be from a list of approved verbs defined within this document
            <noun>: The entity upon which the function is primarily operating upon.
            __<optional>: Allows for extra text to be provided to ensure more clarity of purpose should the verb/noun pair be insufficient.
        Prefix:
            Procedure: ''
            Function: ''
            Trigger: ''
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
        Name Structure: '<prime>(_modifier)_<class>'
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
