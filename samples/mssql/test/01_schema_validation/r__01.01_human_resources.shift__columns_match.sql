
CREATE OR ALTER PROCEDURE test_schema_validation.test_shift__columns_match
AS
BEGIN
 
    CREATE TABLE [human_resources].[shift_tsqlt](
        [shift_id] tinyint NOT NULL
       ,[name] [common].[name] NOT NULL
       ,[start_time] time(7) NOT NULL
       ,[end_time] time(7) NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'human_resources.shift_tsqlt'
                                      ,@Actual = N'human_resources.shift'
                                      ,@Message = N'Column definitions do not match';
END;
GO
