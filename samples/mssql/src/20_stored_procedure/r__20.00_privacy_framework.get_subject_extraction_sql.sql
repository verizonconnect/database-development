-- Copyright 2022. Verizon Connect Ireland Limited. All rights reserved.
CREATE OR ALTER PROCEDURE [privacy_framework].[get_subject_extraction_sql](
        @temp_table_name sysname,
        @subject_type_id INT,
        @schema_name sysname,
        @table_name sysname,
        @column_name sysname,
        @sql_extraction NVARCHAR(MAX) OUTPUT)
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
    DECLARE @subject_data_type_desc				VARCHAR(100);
	DECLARE @subject_data_type_translation_key	VARCHAR(100);


    --Get the other values for this table
    SELECT 	@table_account_id_column_name = tc.account_id_column_name,
            @table_subject_id_column_name = tc.subject_id_column_name,
            @subject_data_type_desc = sdt.subject_data_type_desc,
            @subject_data_type_translation_key = sdt.subject_data_type_translation_key
    FROM privacy_framework.table_configuration AS tc
    INNER JOIN privacy_framework.column_data_dictionary cdd 
            ON  cdd.sch_nm = tc.sch_nm AND cdd.tbl_nm = tc.tbl_nm AND cdd.subject_type_id = @subject_type_id
    INNER JOIN privacy_framework.subject_data_type sdt
            ON sdt.subject_data_type_id = cdd.subject_data_type_id
    WHERE tc.sch_nm = @schema_name
    AND tc.tbl_nm = @table_name
    AND cdd.col_nm = @column_name;


    --Check the table exists
    IF NOT EXISTS(SELECT 1
                  FROM information_schema.tables
                  WHERE table_schema = @schema_name
                    AND table_name = @table_name)
        BEGIN
        SELECT @THROW_ERROR_MESSAGE = 'Error generating Subject Extraction SQL: Table ' + QUOTENAME(@schema_name) + '.' + QUOTENAME(@table_name) + ' from privacy_framework.table_configuration does not exist';
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
        SELECT @THROW_ERROR_MESSAGE = 'Error generating Subject Extraction SQL: Account ID column ' + QUOTENAME(@table_account_id_column_name) + ' for table ' + QUOTENAME(@schema_name) + '.' + QUOTENAME(@table_name) + ' from privacy_framework.table_configuration does not exist';
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
        SELECT @THROW_ERROR_MESSAGE = 'Error generating Subject Extraction SQL: Subject ID column ' + QUOTENAME(@table_subject_id_column_name) + ' for table ' + QUOTENAME(@schema_name) + '.' + QUOTENAME(@table_name) + ' from privacy_framework.table_configuration does not exist';
        THROW 50000, @THROW_ERROR_MESSAGE, 1;            
        RETURN @return_value;                     
        END;

	SELECT @sql_extraction = 'INSERT INTO ' + QUOTENAME(@temp_table_name) +
								' SELECT  ''' + @column_name + ''' as col_nm, ' + 
								' CAST(' + QUOTENAME(@column_name) + ' AS NVARCHAR(MAX)) as col_value, ' +
								'''' + @subject_data_type_desc + ''' as subject_data_type, ' +
								'''' + @subject_data_type_translation_key + ''' as translation_key ' +
								'FROM ' + QUOTENAME(@schema_name) + '.' + QUOTENAME(@table_name) +
								' WHERE ' + QUOTENAME(@table_account_id_column_name) + ' = @account_id' +
								' AND ' + QUOTENAME(@table_subject_id_column_name) + ' = @subject_id';

    SELECT @return_value = 1;
    RETURN @return_value;

END;
GO
