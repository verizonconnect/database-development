-- Copyright 2022. Verizon Connect Ireland Limited. All rights reserved.
CREATE OR ALTER PROCEDURE [privacy_framework].[get_subject_obfuscation_sql](
        @subject_type_id INT,
        @schema_name sysname,
        @table_name sysname,
        @sql_obfuscation NVARCHAR(MAX) OUTPUT)
AS
BEGIN

    SET NOCOUNT ON;

    --Variable declarations
    DECLARE @return_value INT = -1;
    DECLARE @THROW_ERROR_MESSAGE NVARCHAR(2048);

    --Column details
    DECLARE @column                              sysname;
    DECLARE @column_sql                          NVARCHAR(MAX);
    DECLARE @character_maximum_length            INT;
    DECLARE @accountid_character_maximum_length  INT;
    DECLARE @subjectid_character_maximum_length  INT;

    --Table extra details
    DECLARE @table_account_id_column_name        sysname;
    DECLARE @table_modified_utc_when_column_name sysname;
    DECLARE @table_obfuscated_ind_column_name    sysname;
    DECLARE @table_subject_id_column_name        sysname;
    DECLARE @table_batch_size                    INT;

    --Special obfuscation method
    DECLARE @delete_obfuscation_method_id        SMALLINT;
    -- Generate the SQL to obfuscate the table

    --Identify the DELETE method id
    SELECT @delete_obfuscation_method_id =  obfuscation_method_id
    FROM privacy_framework.obfuscation_method
    WHERE obfuscation_method_desc = 'DELETE';

    --Get the other values for this table and subject type - assume only one subject_id column per subject type and table
    SELECT @table_account_id_column_name = tc.account_id_column_name,
           @table_modified_utc_when_column_name = tc.modified_utc_when_column_name,
           @table_obfuscated_ind_column_name = tc.obfuscated_ind_column_name,
           @table_subject_id_column_name = tc.subject_id_column_name,
           @table_batch_size = tc.batch_size
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
        SELECT @THROW_ERROR_MESSAGE = 'Error generating Subject Obfuscation SQL: Table ' + QUOTENAME(@schema_name) + '.' + QUOTENAME(@table_name) + ' from privacy_framework.table_configuration does not exist';
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
        SELECT @THROW_ERROR_MESSAGE = 'Error generating Obfuscation SQL: Account ID column ' + QUOTENAME(@table_account_id_column_name) + ' for table ' + QUOTENAME(@schema_name) + '.' + QUOTENAME(@table_name) + ' from privacy_framework.table_configuration does not exist';
        THROW 50000, @THROW_ERROR_MESSAGE, 1;    
        RETURN @return_value;                             
        END;

    --Check the @table_modified_utc_when_column_name column exists on the table
    IF NOT EXISTS(SELECT 1
                    FROM information_schema.columns
                    WHERE table_schema = @schema_name
                        AND table_name = @table_name
                        AND column_name = @table_modified_utc_when_column_name) 
        BEGIN
        SELECT @THROW_ERROR_MESSAGE = 'Error generating Obfuscation SQL: Modified UTC When column ' + QUOTENAME(@table_modified_utc_when_column_name) + ' for table ' + QUOTENAME(@schema_name) + '.' + QUOTENAME(@table_name) + ' from privacy_framework.table_configuration does not exist';
        THROW 50000, @THROW_ERROR_MESSAGE, 1;           
        RETURN @return_value;                      
        END;


    --Check the @table_obfuscated_ind_column_name column exists on the table
    IF NOT EXISTS(SELECT 1
                    FROM information_schema.columns
                    WHERE table_schema = @schema_name
                        AND table_name = @table_name
                        AND column_name = @table_obfuscated_ind_column_name) 
        BEGIN
        SELECT @THROW_ERROR_MESSAGE = 'Error generating Obfuscation SQL: Obfuscated Ind column ' + QUOTENAME(@table_obfuscated_ind_column_name) + ' for table ' + QUOTENAME(@schema_name) + '.' + QUOTENAME(@table_name) + ' from privacy_framework.table_configuration does not exist';
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
        SELECT @THROW_ERROR_MESSAGE = 'Error generating Obfuscation SQL: Subject ID column ' + QUOTENAME(@table_subject_id_column_name) + ' for table ' + QUOTENAME(@schema_name) + '.' + QUOTENAME(@table_name) + ' from privacy_framework.table_configuration does not exist';
        THROW 50000, @THROW_ERROR_MESSAGE, 1;            
        RETURN @return_value;                     
        END;


    --Build the obfuscation SQL
    SELECT @sql_obfuscation = 'SELECT @rows_updated=0; ';
    IF EXISTS(SELECT 1
              FROM privacy_framework.obfuscation_column_configuration AS C
              INNER JOIN privacy_framework.column_data_dictionary cdd 
                                ON  cdd.sch_nm = C.sch_nm 
                                AND cdd.tbl_nm = C.tbl_nm 
                                AND cdd.col_nm = C.col_nm 
              WHERE C.sch_nm = @schema_name
                AND C.tbl_nm = @table_name
                AND C.obfuscated_subject_level_indicator = 1
                AND cdd.subject_type_id = @subject_type_id
                AND C.obfuscation_method_id = @delete_obfuscation_method_id) 
        BEGIN
        SELECT @sql_obfuscation = @sql_obfuscation + 'DELETE FROM ' + QUOTENAME(@schema_name) + '.' + QUOTENAME(@table_name);
        END;
    ELSE
        BEGIN
        SELECT @sql_obfuscation = @sql_obfuscation + 'UPDATE top(' + cast(@table_batch_size as varchar(10)) + ') ' + QUOTENAME(@schema_name) + '.' + QUOTENAME(@table_name) + ' SET ';

        DECLARE Column_Loop CURSOR FOR
        SELECT C.col_nm, M.obfuscation_method_desc
        FROM privacy_framework.obfuscation_method AS M
                    INNER JOIN privacy_framework.obfuscation_column_configuration AS C ON C.obfuscation_method_id = M.obfuscation_method_id
                    INNER JOIN privacy_framework.column_data_dictionary cdd 
                            ON  cdd.sch_nm = C.sch_nm 
                            AND cdd.tbl_nm = C.tbl_nm 
                            AND cdd.col_nm = C.col_nm 
        WHERE C.sch_nm = @schema_name
            AND C.tbl_nm = @table_name
            AND C.obfuscated_subject_level_indicator = 1
            AND cdd.subject_type_id = @subject_type_id
        OPEN Column_Loop;
        FETCH NEXT FROM Column_Loop INTO @column, @column_sql;
        WHILE (@@fetch_Status = 0)
            BEGIN
            IF (CHARINDEX('select', @column_sql) = 0)
                BEGIN
                SELECT @THROW_ERROR_MESSAGE = 'No SELECT detected in Obfuscation Method for ' + QUOTENAME(@schema_name) + '.' + QUOTENAME(@table_name) + '.' + QUOTENAME(@column) + ' : MethodValue: ' + @column_sql;
                THROW 50000, @THROW_ERROR_MESSAGE, 1;
                RETURN @return_value;
                END;
            SELECT @column_sql = right(@column_sql, LEN(@column_sql) - CHARINDEX('select', @column_sql) - 5);

            --Get the length of the column
            SELECT @character_maximum_length = character_maximum_length
            FROM information_schema.columns
            WHERE table_schema = @schema_name
                AND table_name = @table_name
                AND column_name = @column;
            IF @column_sql IS NULL OR @character_maximum_length IS NULL 
                BEGIN
                -- If updating to null or the column character length is null (so not a character column of limited length) then do a normal update
                -- This will also catch text columns - these do not need to be truncated
                SELECT @sql_obfuscation = @sql_obfuscation + QUOTENAME(@column) + ' = ' + @column_sql + ',';
                END;
            ELSE
                BEGIN
                --Limit the updated value to the column length
                SELECT @sql_obfuscation = @sql_obfuscation + QUOTENAME(@column) + ' = left(' + @column_sql + ', ' + cast(@character_maximum_length as VARCHAR(10)) + '),';
                END;
            FETCH NEXT FROM Column_Loop INTO @column, @column_sql;
            END;

            CLOSE Column_Loop;
            DEALLOCATE Column_Loop;    

            SELECT @sql_obfuscation = SUBSTRING(@sql_obfuscation, 1, LEN(@sql_obfuscation) - 1);

            SELECT @sql_obfuscation = @sql_obfuscation + ', ' + QUOTENAME(@table_modified_utc_when_column_name) + ' = SYSUTCDATETIME() ';
            SELECT @sql_obfuscation = @sql_obfuscation + ', ' + QUOTENAME(@table_obfuscated_ind_column_name) + ' = 1 ';
        END;

    SELECT @sql_obfuscation = @sql_obfuscation + ' WHERE ' + QUOTENAME(@table_account_id_column_name) + ' = @account_id';

    SELECT @sql_obfuscation = @sql_obfuscation + ' AND ' + QUOTENAME(@table_subject_id_column_name) + ' = @subject_id';

    SELECT @sql_obfuscation = @sql_obfuscation + ' AND COALESCE(' + QUOTENAME(@table_obfuscated_ind_column_name) + ', 0) = 0;';

    SELECT @sql_obfuscation = @sql_obfuscation + ' SELECT @rows_updated = @@rowcount; ';

    SELECT @return_value = 1;
    RETURN @return_value;
END;
GO
