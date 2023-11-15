-- Copyright 2022. Verizon Connect Ireland Limited. All rights reserved.
CREATE OR ALTER PROCEDURE [privacy_framework].[get_subject_backup_sql](
        @subject_type_id INT,
        @schema_name sysname,
        @table_name sysname,
        @sql_backup NVARCHAR(MAX) OUTPUT)
AS
BEGIN

    SET NOCOUNT ON;

    --Variable declarations
    DECLARE @return_value INT = -1;
    DECLARE @THROW_ERROR_MESSAGE NVARCHAR(2048);
    --Variable declarations
    DECLARE @backup_schema_name                 sysname;
    DECLARE @accountid_character_maximum_length INT;
    DECLARE @subjectid_character_maximum_length INT;

    --Table extra details
    DECLARE @table_account_id_column_name       sysname;
    DECLARE @table_subject_id_column_name       sysname;
    DECLARE @backup_table_name                  sysname;


    --Get the other values for this table
    SELECT @table_account_id_column_name = tc.account_id_column_name,
           @table_subject_id_column_name = tc.subject_id_column_name
    FROM privacy_framework.table_configuration AS tc
    WHERE tc.sch_nm = @schema_name
      AND tc.tbl_nm = @table_name
      AND EXISTS (SELECT 1 FROM privacy_framework.obfuscation_column_configuration cc 
            WHERE  cc.sch_nm = tc.sch_nm AND cc.tbl_nm = tc.tbl_nm AND cc.obfuscated_subject_level_indicator = 1);


    --Check the table exists
    IF NOT EXISTS(SELECT 1
                  FROM information_schema.tables
                  WHERE table_schema = @schema_name
                    AND table_name = @table_name)
        BEGIN
        SELECT @THROW_ERROR_MESSAGE = 'Error generating Subject Backup SQL: Table ' + QUOTENAME(@schema_name) + '.' + QUOTENAME(@table_name) + ' from privacy_framework.table_configuration does not exist';
        THROW 50000, @THROW_ERROR_MESSAGE, 1;       
        RETURN @return_value;             
        END;

    --Check the @table_account_id_column_name column exists on the table
    IF NOT EXISTS(SELECT 1
                  FROM information_schema.columns
                  WHERE table_schema = @schema_name
                    AND table_name = @table_name
                    AND column_name = @table_account_id_column_name) 
        BEGIN
        SELECT @THROW_ERROR_MESSAGE = 'Error generating Subject Backup SQL: Account ID column ' + QUOTENAME(@table_account_id_column_name) + ' for table ' + QUOTENAME(@schema_name) + '.' + QUOTENAME(@table_name) + ' from privacy_framework.table_configuration does not exist';
        THROW 50000, @THROW_ERROR_MESSAGE, 1;    
        RETURN @return_value;                             
        END;


    --Check the @table_subject_id_column_name column exists on the table
    IF NOT EXISTS(SELECT 1
                    FROM information_schema.columns
                    WHERE table_schema = @schema_name
                        AND table_name = @table_name
                        AND column_name = @table_subject_id_column_name) 
        BEGIN
        SELECT @THROW_ERROR_MESSAGE = 'Error generating Subject Backup SQL: Subject ID column ' + QUOTENAME(@table_subject_id_column_name) + ' for table ' + QUOTENAME(@schema_name) + '.' + QUOTENAME(@table_name) + ' from privacy_framework.table_configuration does not exist';
        THROW 50000, @THROW_ERROR_MESSAGE, 1;            
        RETURN @return_value;                     
        END;


    -- Backup schema are named: privacy_framework_backup_schemaname
    SELECT @backup_schema_name = 'privacy_framework_backup_' + @schema_name;

    --Generate the SQL needed to backup this table for this account
    --Check if the schema exists
    IF NOT EXISTS(SELECT 1 FROM information_schema.schemata WHERE schema_name = @backup_schema_name)
        BEGIN
        SELECT @THROW_ERROR_MESSAGE = 'Error generating Backup SQL: Backup schema ' + QUOTENAME(@backup_schema_name) + ' does not exist';
        THROW 50000, @THROW_ERROR_MESSAGE, 1;            
        RETURN @return_value;   
        END;

    SELECT @backup_table_name = QUOTENAME(@backup_schema_name) + '.' + QUOTENAME(@table_name + '_' + FORMAT (SYSUTCDATETIME(), 'yyyyMMdd'));


    --Create the table if it does not already exist
    
    SELECT @sql_backup = 'IF OBJECT_ID(''' + @backup_table_name + ''') IS NULL BEGIN ' +
                         'SELECT S.* INTO ' + @backup_table_name + ' FROM ' + QUOTENAME(@schema_name) + '.' + QUOTENAME(@table_name) + ' AS S WHERE 1=2 ' +
                         'UNION SELECT S.*  FROM ' + QUOTENAME(@schema_name) + '.' + QUOTENAME(@table_name) + ' AS S WHERE 1=2; ' + --Prevent identity column being inherited
                         'CREATE CLUSTERED INDEX ci_backup_temp on ' + @backup_table_name + ' (' + @table_subject_id_column_name + ') ON FRAMEWORK_UNPART; ' +
                         'DROP INDEX ' + @backup_table_name + '.' + QUOTENAME('ci_backup_temp') + '; ' +
                         'END; ';

    --Insert the data to backup
    SELECT @sql_backup = @sql_backup + ' INSERT INTO ' + @backup_table_name + ' SELECT * FROM ' + QUOTENAME(@schema_name) + '.' + QUOTENAME(@table_name);

    SELECT @sql_backup = @sql_backup + ' WHERE ' + QUOTENAME(@table_account_id_column_name) + ' = @account_id ';

    SELECT @sql_backup = @sql_backup + ' AND ' +  QUOTENAME(@table_subject_id_column_name) + ' = @subject_id;';

    SELECT @return_value = 1;
    RETURN @return_value;

END;
GO