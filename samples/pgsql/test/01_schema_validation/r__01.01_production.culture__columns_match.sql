
CREATE OR ALTER PROCEDURE test_schema_validation.test_culture__columns_match
AS
BEGIN
 
    CREATE TABLE [production].[culture_tsqlt](
        [culture_id] nchar(6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[name] [common].[name] NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'production.culture_tsqlt'
                                      ,@Actual = N'production.culture'
                                      ,@Message = N'Column definitions do not match';
END;
GO
