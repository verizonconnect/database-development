/* Copyright 2022. Verizon Connect Ireland Limited. All rights reserved. */
CREATE OR ALTER PROCEDURE [privacy_framework].[obfuscate_subject]
(	@account_id INT,
    @subject_type_id INT,
    @subject_id INT,
	@debug_ind BIT = 0
)
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @Error_Message NVARCHAR(4000);
    DECLARE @Error_Number INT;
   	DECLARE @THROW_ERROR_MESSAGE NVARCHAR(2048);


    DECLARE @return_value INT = -1;

    --status definitions
    DECLARE @status_inprogress SMALLINT = 1;
    DECLARE @status_complete   SMALLINT = 2;
    DECLARE @status_error      SMALLINT = 3;

    --SQL to run
    DECLARE @sql_obfuscation   NVARCHAR(MAX) = '';
    DECLARE @sql_backup        NVARCHAR(MAX) = '';

    --Loop through tables
    DECLARE @loop_schema_name  sysname = NULL;
    DECLARE @loop_table_name   sysname = NULL;

    --Other
    DECLARE @backup_table_retention        INT = 7; --How many days to keep the backup tables
    DECLARE @obfuscation_rowcount          INT = 0;
    DECLARE @loop_account_id_column_name   sysname;
    DECLARE @log_message                   VARCHAR(MAX) = '';         
    DECLARE @rows_updated                  INT;

    -- If param_debug_ind is set then will just get the backup and obfuscation SQL

    -- Step 1
    -- Remove any backup tables older than the retention period
    SELECT @log_message = 'AccountID: ' + cast(@account_id as VARCHAR(10)) + ' | Begin obfuscation function';
    EXEC privacy_framework.add_obfuscation_log @message = @log_message, @debug_ind = @debug_ind;

    IF (@debug_ind = 0)
        BEGIN
        BEGIN TRY
            SELECT @log_message = 'AccountID: ' + cast(@account_id as VARCHAR(10)) + ' | Drop old backup tables';
            EXEC privacy_framework.add_obfuscation_log @message = @log_message, @debug_ind = @debug_ind;
            EXEC privacy_framework.drop_old_backup_tables @days_to_keep = @backup_table_retention;
        END TRY
        BEGIN CATCH
            SELECT @Error_Number = ERROR_NUMBER();
            SELECT @Error_Message = ERROR_MESSAGE();
            SELECT @THROW_ERROR_MESSAGE = 'Error adding to the obfuscation log: ' + ' ERROR ' + ISNULL(CONVERT(VARCHAR(20), @Error_Number), '') + ': ' + ISNULL(@Error_Message, '');
            EXEC @return_value = privacy_framework.obfuscate_subject_error @account_id = @account_id, @subject_type_id = @subject_type_id, @subject_id = @subject_id, 
                                                        @schema_name = @loop_schema_name, @table_name = @loop_table_name, @sqlerrm = @THROW_ERROR_MESSAGE, @debug_ind = @debug_ind;
            RETURN @return_value;
        END CATCH;
        END;  	
        
    -- Step 2
    -- Has the obfuscation been done already in this account for this subject?
    IF EXISTS(SELECT 1 FROM privacy_framework.obfuscation_account_status s WHERE s.account_id = @account_id AND status_id = @status_complete)
        BEGIN
        -- This account is already obfuscated - no need to do anything
        SELECT @log_message = 'AccountID: ' + cast(@account_id as VARCHAR(10)) + ' | Is already obfuscated';
        EXEC privacy_framework.add_obfuscation_log @message = @log_message, @debug_ind = @debug_ind;

        SELECT @return_value = 1;
        RETURN @return_value;
        END;
    IF EXISTS(SELECT 1 FROM privacy_framework.obfuscation_subject_status s WHERE s.account_id = @account_id AND s.subject_type_id = @subject_type_id 
                AND s.subject_id = @subject_id AND status_id = @status_complete)
        BEGIN
        -- This subject for this account is already obfuscated - no need to do anything
        SELECT @log_message = 'AccountID: ' + cast(@account_id as VARCHAR(10)) + ' SubjectTypeID: ' + cast(@subject_type_id as VARCHAR(10)) + ' SubjectID: ' + cast(@subject_id as VARCHAR(10)) + ' | Is already obfuscated';
        EXEC privacy_framework.add_obfuscation_log @message = @log_message, @debug_ind = @debug_ind;
        SELECT @return_value = 1;
        RETURN @return_value;
        END;

    --Add an inprogress status record for the subject
    EXEC privacy_framework.set_obfuscation_subject_status @account_id = @account_id, @subject_type_id = @subject_type_id, @subject_id = @subject_id, 
                                @status_id = @status_inprogress, @debug_ind = @debug_ind;

    -- Step 3
    -- Loop through the tables for subject level obfuscation
    SELECT @log_message = 'AccountID: ' + cast(@account_id as VARCHAR(10)) + ' SubjectTypeID: ' + cast(@subject_type_id as VARCHAR(10)) + ' SubjectID: ' + cast(@subject_id as VARCHAR(10)) + ' | Getting tables to obfuscate';
    EXEC privacy_framework.add_obfuscation_log @message = @log_message, @debug_ind = @debug_ind;

    DECLARE Table_Loop CURSOR FOR
        SELECT tc.sch_nm,
                tc.tbl_nm,
                tc.account_id_column_name
        FROM privacy_framework.table_configuration tc
        WHERE EXISTS(   SELECT  1 
                        FROM    privacy_framework.obfuscation_column_configuration cc 
                        INNER JOIN  privacy_framework.column_data_dictionary cdd 
                                ON  cdd.sch_nm = cc.sch_nm 
                                AND cdd.tbl_nm = cc.tbl_nm 
                                AND cdd.col_nm = cc.col_nm 
                                AND cdd.subject_type_id = @subject_type_id 
                        WHERE   cc.sch_nm = tc.sch_nm 
                        AND     cc.tbl_nm = tc.tbl_nm 
                        AND     cc.obfuscated_subject_level_indicator = 1
                        )
        --and not be already obfuscated as part of a previous obfuscation
        AND NOT EXISTS(SELECT 1
                        FROM privacy_framework.obfuscation_account_table_status ats
                        WHERE ats.sch_nm = tc.sch_nm
                        AND ats.tbl_nm = tc.tbl_nm
                        AND ats.account_id = @account_id
                        AND ats.status_id = @status_complete)
        AND NOT EXISTS(SELECT 1
                        FROM privacy_framework.obfuscation_subject_table_status ats
                        WHERE ats.sch_nm = tc.sch_nm
                        AND ats.tbl_nm = tc.tbl_nm
                        AND ats.account_id = @account_id
                        AND ats.subject_type_id = @subject_type_id 
                        AND ats.subject_id = @subject_id
                        AND ats.status_id = @status_complete)
        ORDER BY sch_nm,
                tbl_nm;
    OPEN Table_Loop;
    FETCH NEXT FROM Table_Loop INTO @loop_schema_name, @loop_table_name, @loop_account_id_column_name;
	WHILE (@@fetch_Status = 0)
		BEGIN
        EXEC privacy_framework.set_obfuscation_subject_table_status @account_id = @account_id, 
                                                                    @subject_type_id = @subject_type_id, 
                                                                    @subject_id = @subject_id, 
                                                                    @schema_name = @loop_schema_name, 
                                                                    @table_name = @loop_table_name, 
                                                                    @obfuscation_row_count = 0, 
                                                                    @status_id = @status_inprogress, 
                                                                    @debug_ind = @debug_ind;

        -- Step 3a
        -- Get the SQL to obfuscate
        SELECT @log_message = 'AccountID: ' + cast(@account_id as VARCHAR(10)) + ' SubjectTypeID: ' + cast(@subject_type_id as VARCHAR(10)) + ' SubjectID: ' + cast(@subject_id as VARCHAR(10)) + ' Table : ' + QUOTENAME(@loop_schema_name) + '.' + QUOTENAME(@loop_table_name) + 
                ' | Getting obfuscation SQL';
        EXEC privacy_framework.add_obfuscation_log @message = @log_message, @debug_ind = @debug_ind;

        BEGIN TRY
            EXEC @return_value = privacy_framework.get_subject_obfuscation_sql @subject_type_id = @subject_type_id, @schema_name = @loop_schema_name, @table_name = @loop_table_name, @sql_obfuscation = @sql_obfuscation OUTPUT;
        END TRY
        BEGIN CATCH
            SELECT @Error_Number = ERROR_NUMBER();
            SELECT @Error_Message = ERROR_MESSAGE();
            SELECT @THROW_ERROR_MESSAGE = 'Error getting subject obfuscation SQL: ' + ' ERROR ' + ISNULL(CONVERT(VARCHAR(20), @Error_Number), '') + ': ' + ISNULL(@Error_Message, '');
            EXEC @return_value = privacy_framework.obfuscate_subject_error @account_id = @account_id, @subject_type_id = @subject_type_id, @subject_id = @subject_id, 
                                                        @schema_name = @loop_schema_name, @table_name = @loop_table_name, @sqlerrm = @THROW_ERROR_MESSAGE, @debug_ind = @debug_ind;
            RETURN @return_value;
        END CATCH;     

        SELECT @log_message = 'AccountID: ' + cast(@account_id as VARCHAR(10)) + ' SubjectTypeID: ' + cast(@subject_type_id as VARCHAR(10)) + ' SubjectID: ' + cast(@subject_id as VARCHAR(10)) + ' Table : ' + QUOTENAME(@loop_schema_name) + '.' + QUOTENAME(@loop_table_name) + 
                ' | Obfuscation SQL is: ' + @sql_obfuscation;
        EXEC privacy_framework.add_obfuscation_log @message = @log_message, @debug_ind = @debug_ind;

        -- Step 3b
        -- Get the SQL to backup the table
        SELECT @log_message = 'AccountID: ' + cast(@account_id as VARCHAR(10)) + ' SubjectTypeID: ' + cast(@subject_type_id as VARCHAR(10)) + ' SubjectID: ' + cast(@subject_id as VARCHAR(10)) + ' Table : ' + QUOTENAME(@loop_schema_name) + '.' + QUOTENAME(@loop_table_name) + 
                ' | Getting backup SQL for table';
        EXEC privacy_framework.add_obfuscation_log @message = @log_message, @debug_ind = @debug_ind;

        BEGIN TRY
            EXEC @return_value = privacy_framework.get_subject_backup_sql @subject_type_id = @subject_type_id, @schema_name = @loop_schema_name, @table_name = @loop_table_name, @sql_backup = @sql_backup OUTPUT;
        END TRY
        BEGIN CATCH
            SELECT @Error_Number = ERROR_NUMBER();
            SELECT @Error_Message = ERROR_MESSAGE();
            SELECT @THROW_ERROR_MESSAGE = 'Error getting subject backup SQL: ' + ' ERROR ' + ISNULL(CONVERT(VARCHAR(20), @Error_Number), '') + ': ' + ISNULL(@Error_Message, '');
            EXEC @return_value = privacy_framework.obfuscate_subject_error @account_id = @account_id, @subject_type_id = @subject_type_id, @subject_id = @subject_id, 
                                                        @schema_name = @loop_schema_name, @table_name = @loop_table_name, @sqlerrm = @THROW_ERROR_MESSAGE, @debug_ind = @debug_ind;
            RETURN @return_value;
        END CATCH; 

        SELECT @log_message = 'AccountID: ' + cast(@account_id as VARCHAR(10)) + ' SubjectTypeID: ' + cast(@subject_type_id as VARCHAR(10)) + ' SubjectID: ' + cast(@subject_id as VARCHAR(10)) + ' Table : ' + QUOTENAME(@loop_schema_name) + '.' + QUOTENAME(@loop_table_name) + 
                ' | Backup SQL is: ' + @sql_backup;
        EXEC privacy_framework.add_obfuscation_log @message = @log_message, @debug_ind = @debug_ind;

        -- Step 3c
        -- Run the backup SQL - or just output for debug
        IF @debug_ind = 1
            BEGIN
            SELECT 'Backup SQL: ' + @sql_backup as Message;
            END;
        ELSE
            BEGIN
            SELECT @log_message = 'AccountID: ' + cast(@account_id as VARCHAR(10)) + ' SubjectTypeID: ' + cast(@subject_type_id as VARCHAR(10)) + ' SubjectID: ' + cast(@subject_id as VARCHAR(10)) + ' Table : ' + QUOTENAME(@loop_schema_name) + '.' + QUOTENAME(@loop_table_name) + 
                ' | Executing backup SQL';
            EXEC privacy_framework.add_obfuscation_log @message = @log_message, @debug_ind = @debug_ind;
            BEGIN TRY
                --Run the backup SQL
                EXECUTE SP_executesql @sql_backup, N'@account_id int, @subject_id int', @account_id, @subject_id;
            END TRY
            BEGIN CATCH
                SELECT @Error_Number = ERROR_NUMBER();
                SELECT @Error_Message = ERROR_MESSAGE();
                SELECT @THROW_ERROR_MESSAGE = 'Error running backup SQL: ' + ' ERROR ' + ISNULL(CONVERT(VARCHAR(20), @Error_Number), '') + ': ' + ISNULL(@Error_Message, '');
                EXEC @return_value = privacy_framework.obfuscate_subject_error @account_id = @account_id, @subject_type_id = @subject_type_id, @subject_id = @subject_id, 
                                                        @schema_name = @loop_schema_name, @table_name = @loop_table_name, @sqlerrm = @THROW_ERROR_MESSAGE, @debug_ind = @debug_ind;
                RETURN @return_value;
            END CATCH; 
            END;

        -- Step 3d
        -- Run the obfuscation SQL - or just output for debug
        SELECT @obfuscation_rowcount = 0;

        IF @debug_ind = 1
            BEGIN
            SELECT 'Obfuscation SQL: ' + @sql_obfuscation as Message;
            END;
        ELSE
            BEGIN
            SELECT @log_message = 'AccountID: ' + cast(@account_id as VARCHAR(10)) + ' SubjectTypeID: ' + cast(@subject_type_id as VARCHAR(10)) + ' SubjectID: ' + cast(@subject_id as VARCHAR(10)) + ' Table : ' + QUOTENAME(@loop_schema_name) + '.' + QUOTENAME(@loop_table_name) + 
                ' | Executing obfuscation SQL';
            EXEC privacy_framework.add_obfuscation_log @message = @log_message, @debug_ind = @debug_ind;
            BEGIN TRY
                --Run the obfuscation SQL
    			-- If we're not in debug, then we can run the actual obfuscation SQL to do the update
				SELECT @rows_updated = 1; --Allow the update to start
                SELECT @obfuscation_rowcount = 0;
				WHILE (@rows_updated > 0)
					BEGIN
                    EXECUTE SP_executesql @sql_obfuscation, N'@account_id int, @subject_id int, @rows_updated int output', @account_id, @subject_id, @rows_updated OUTPUT;
                    SELECT @obfuscation_rowcount = @obfuscation_rowcount + @rows_updated;
					END;
            END TRY
            BEGIN CATCH
                SELECT @Error_Number = ERROR_NUMBER();
                SELECT @Error_Message = ERROR_MESSAGE();
                SELECT @THROW_ERROR_MESSAGE = 'Error running obfuscation SQL: ' + ' ERROR ' + ISNULL(CONVERT(VARCHAR(20), @Error_Number), '') + ': ' + ISNULL(@Error_Message, '');
                EXEC @return_value = privacy_framework.obfuscate_subject_error @account_id = @account_id, @subject_type_id = @subject_type_id, @subject_id = @subject_id, 
                                                        @schema_name = @loop_schema_name, @table_name = @loop_table_name, @sqlerrm = @THROW_ERROR_MESSAGE, @debug_ind = @debug_ind;
                RETURN @return_value;
            END CATCH; 
            END;

        -- Step 3e
        -- Log the result
        EXEC privacy_framework.set_obfuscation_subject_table_status @account_id = @account_id, @subject_type_id = @subject_type_id, @subject_id = @subject_id, @schema_name = @loop_schema_name, 
                                    @table_name = @loop_table_name, @obfuscation_row_count = @obfuscation_rowcount, @status_id = @status_complete, @debug_ind = @debug_ind;




        SELECT @log_message = 'AccountID: ' + cast(@account_id as VARCHAR(10)) + ' SubjectTypeID: ' + cast(@subject_type_id as VARCHAR(10)) + ' SubjectID: ' + cast(@subject_id as VARCHAR(10)) + ' Table : ' + QUOTENAME(@loop_schema_name) + '.' + QUOTENAME(@loop_table_name) + 
                ' | Obfuscation Complete';
        EXEC privacy_framework.add_obfuscation_log @message = @log_message, @debug_ind = @debug_ind;
       
        FETCH NEXT FROM Table_Loop INTO @loop_schema_name, @loop_table_name, @loop_account_id_column_name;
        END;

    CLOSE Table_Loop;
    DEALLOCATE Table_Loop;    

	EXEC privacy_framework.set_obfuscation_subject_status @account_id = @account_id, @subject_type_id = @subject_type_id, @subject_id = @subject_id, 
							@status_id = @status_complete, @debug_ind = @debug_ind;
    SELECT @log_message = 'AccountID: ' + cast(@account_id as VARCHAR(10)) + ' SubjectTypeID: ' + cast(@subject_type_id as VARCHAR(10)) + ' SubjectID: ' + cast(@subject_id as VARCHAR(10)) + 
                ' | Obfuscation Complete';
    EXEC privacy_framework.add_obfuscation_log @message = @log_message, @debug_ind = @debug_ind;

    SELECT @return_value = 1;
    RETURN @return_value;    
    
END;
GO