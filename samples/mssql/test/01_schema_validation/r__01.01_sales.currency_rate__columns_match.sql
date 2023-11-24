
CREATE OR ALTER PROCEDURE test_schema_validation.test_currency_rate__columns_match
AS
BEGIN
 
    CREATE TABLE [sales].[currency_rate_tsqlt](
        [currency_rate_id] int NOT NULL
       ,[currency_rate_date] datetime NOT NULL
       ,[from_currency_code] nchar(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[to_currency_code] nchar(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[average_rate] money NOT NULL
       ,[end_of_day_rate] money NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'sales.currency_rate_tsqlt'
                                      ,@Actual = N'sales.currency_rate'
                                      ,@Message = N'Column definitions do not match';
END;
GO
