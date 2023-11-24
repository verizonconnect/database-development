
CREATE OR ALTER PROCEDURE test_schema_validation.test_country_region_currency__columns_match
AS
BEGIN
 
    CREATE TABLE [sales].[country_region_currency_tsqlt](
        [country_region_code] nvarchar(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[currency_code] nchar(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'sales.country_region_currency_tsqlt'
                                      ,@Actual = N'sales.country_region_currency'
                                      ,@Message = N'Column definitions do not match';
END;
GO
