
CREATE OR ALTER PROCEDURE test_schema_validation.test_illustration__columns_match
AS
BEGIN
 
    CREATE TABLE [production].[illustration_tsqlt](
        [illustration_id] int NOT NULL
       ,[diagram] xml NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'production.illustration_tsqlt'
                                      ,@Actual = N'production.illustration'
                                      ,@Message = N'Column definitions do not match';
END;
GO
