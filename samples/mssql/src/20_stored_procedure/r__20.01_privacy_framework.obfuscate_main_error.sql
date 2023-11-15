/* Copyright 2022. Verizon Connect Ireland Limited. All rights reserved. */
CREATE OR ALTER PROCEDURE [privacy_framework].[obfuscate_main_error]
(	@account_id INT,
    @schema_name sysname,
    @table_name sysname,
    @sqlerrm NVARCHAR(4000), 
	@debug_ind BIT = 0
)
AS
BEGIN
	SET NOCOUNT ON;
    --return
    DECLARE @return_value INT = -1;

    --status definitions
    DECLARE @status_error SMALLINT = 3;
    DECLARE @log_message  VARCHAR(MAX) = '';

    --Deal gracefully with any errors
    IF @table_name IS NULL
        BEGIN
        SELECT @log_message = 'AccountID: ' + cast(@account_id as VARCHAR(10))  + ' | ' + @sqlerrm;
        EXEC privacy_framework.add_obfuscation_log @message = @log_message, @debug_ind = @debug_ind;
        END;
    ELSE
        BEGIN
        SELECT @log_message = 'AccountID: ' + cast(@account_id as VARCHAR(10)) + ' | Table: ' + QUOTENAME(@schema_name) + '.' + QUOTENAME(@table_name) + ' | ' + @sqlerrm;
        EXEC privacy_framework.add_obfuscation_log @message = @log_message, @debug_ind = @debug_ind;
        EXEC privacy_framework.set_obfuscation_account_table_status @account_id = @account_id, @schema_name = @schema_name, 
                                    @table_name = @table_name, @obfuscation_row_count = NULL, @status_id = @status_error, @debug_ind = @debug_ind;
        END;
    EXEC privacy_framework.set_obfuscation_account_status @account_id = @account_id, @status_id = @status_error, @debug_ind = @debug_ind;
    
    THROW 50000, @sqlerrm, 1;
    
    RETURN @return_value;      
END;
GO
