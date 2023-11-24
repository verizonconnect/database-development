
CREATE OR ALTER PROCEDURE test_schema_validation.test_currency__columns_match
AS
BEGIN
 
    CREATE TABLE [sales].[currency_tsqlt](
        [currency_code] nchar(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[name] [common].[name] NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'sales.currency_tsqlt'
                                      ,@Actual = N'sales.currency'
                                      ,@Message = N'Column definitions do not match';
END;
GO
