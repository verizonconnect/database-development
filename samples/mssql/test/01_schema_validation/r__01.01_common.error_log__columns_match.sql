
CREATE OR ALTER PROCEDURE test_schema_validation.test_error_log__columns_match
AS
BEGIN
 
    CREATE TABLE [common].[error_log_tsqlt](
        [error_log_id] int NOT NULL
       ,[error_time] datetime NOT NULL
       ,[user_name] sysname NOT NULL
       ,[error_number] int NOT NULL
       ,[error_severity] int NULL
       ,[error_state] int NULL
       ,[error_procedure] nvarchar(126) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
       ,[error_line] int NULL
       ,[error_message] nvarchar(4000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'common.error_log_tsqlt'
                                      ,@Actual = N'common.error_log'
                                      ,@Message = N'Column definitions do not match';
END;
GO
