
CREATE OR ALTER PROCEDURE test_schema_validation.test_scrap_reason__columns_match
AS
BEGIN
 
    CREATE TABLE [production].[scrap_reason_tsqlt](
        [scrap_reason_id] smallint NOT NULL
       ,[name] [common].[name] NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'production.scrap_reason_tsqlt'
                                      ,@Actual = N'production.scrap_reason'
                                      ,@Message = N'Column definitions do not match';
END;
GO
