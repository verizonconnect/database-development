-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_programmable_object.test_privacy_framework__drop_old_backup_tables
AS
BEGIN

    --create the schemas and tables to be dropped
	declare @backup_table_name sysname;
	declare @sql_backup varchar(max);

    if schema_id('privacy_framework_backup_test') is null
        exec ('create schema privacy_framework_backup_test')

    CREATE TABLE test_programmable_object.test_privacy_framework_backup_tables 
        (table_name sysname not null);

    --Today
    SELECT @backup_table_name = 'privacy_framework_backup_test.today_' + FORMAT (SYSUTCDATETIME(), 'yyyyMMdd');
    SELECT @sql_backup = 'CREATE TABLE ' + @backup_table_name + ' (cola int);';
    EXEC (@sql_backup);
    INSERT INTO test_programmable_object.test_privacy_framework_backup_tables values(@backup_table_name);

    --29 days ago
    SELECT @backup_table_name = 'privacy_framework_backup_test.daysago29_' + FORMAT (dateadd(day, -29, SYSUTCDATETIME()), 'yyyyMMdd');
    SELECT @sql_backup = 'CREATE TABLE ' + @backup_table_name + ' (cola int);';
    EXEC (@sql_backup);
    INSERT INTO test_programmable_object.test_privacy_framework_backup_tables values(@backup_table_name);

    --30 days ago
    SELECT @backup_table_name = 'privacy_framework_backup_test.daysago30_' + FORMAT (dateadd(day, -30, SYSUTCDATETIME()), 'yyyyMMdd');
    SELECT @sql_backup = 'CREATE TABLE ' + @backup_table_name + ' (cola int);';
    EXEC (@sql_backup);
    INSERT INTO test_programmable_object.test_privacy_framework_backup_tables values(@backup_table_name);

    --31 days ago
    SELECT @backup_table_name = 'privacy_framework_backup_test.daysago31_' + FORMAT (dateadd(day, -31, SYSUTCDATETIME()), 'yyyyMMdd');
    SELECT @sql_backup = 'CREATE TABLE ' + @backup_table_name + ' (cola int);';
    EXEC (@sql_backup);
    INSERT INTO test_programmable_object.test_privacy_framework_backup_tables values(@backup_table_name);


    --Check the existing schemas and tables
    SELECT table_name 
    INTO #expected_resultset
    FROM test_programmable_object.test_privacy_framework_backup_tables
    order by table_name;

    SELECT cast(table_schema + '.' + table_name as sysname) as table_name 
    INTO #actual_resultset
    FROM information_schema.tables 
    where table_schema = 'privacy_framework_backup_test' order by table_name;


    EXEC tSQLt.AssertEqualsTable @Expected = N'#expected_resultset'
                                ,@Actual = N'#actual_resultset'
                                ,@Message = N'The lists expected_resultset and actual_resultset should match';


    --run the SP to drop the old tables
    EXECUTE privacy_framework.drop_old_backup_tables @days_to_keep = 30; --Will keep 30 days of backup tables including today...

    SELECT table_name 
    INTO #expected_resultset2
    FROM test_programmable_object.test_privacy_framework_backup_tables 
    where table_name not like 'privacy_framework_backup_test.daysago31_%' 
    and table_name not like 'privacy_framework_backup_test.daysago30_%' 
    order by table_name;

    SELECT cast(table_schema + '.' + table_name as sysname) as table_name 
    INTO #actual_resultset2
    FROM information_schema.tables 
    where table_schema = 'privacy_framework_backup_test' order by table_name;


    EXEC tSQLt.AssertEqualsTable @Expected = N'#expected_resultset2'
                            ,@Actual = N'#actual_resultset2'
                            ,@Message = N'The lists expected_resultset2 and actual_resultset2 should match';

END;
GO
