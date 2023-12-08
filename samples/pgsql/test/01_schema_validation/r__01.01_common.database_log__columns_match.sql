
CREATE OR ALTER PROCEDURE test_schema_validation.test_database_log__columns_match
AS
BEGIN
 
    CREATE TABLE [common].[database_log_tsqlt](
        [database_log_id] int NOT NULL
       ,[post_time] datetime NOT NULL
       ,[database_user] sysname NOT NULL
       ,[event] sysname NOT NULL
       ,[schema] sysname NULL
       ,[object] sysname NULL
       ,[tsql] nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[xml_event] xml NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'common.database_log_tsqlt'
                                      ,@Actual = N'common.database_log'
                                      ,@Message = N'Column definitions do not match';
END;
GO
