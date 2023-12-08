
CREATE OR ALTER PROCEDURE test_schema_validation.test_sales_tax_rate__columns_match
AS
BEGIN
 
    CREATE TABLE [sales].[sales_tax_rate_tsqlt](
        [sales_tax_rate_id] int NOT NULL
       ,[state_province_id] int NOT NULL
       ,[tax_type] tinyint NOT NULL
       ,[tax_rate] smallmoney NOT NULL
       ,[name] [common].[name] NOT NULL
       ,[rowguid] uniqueidentifier NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'sales.sales_tax_rate_tsqlt'
                                      ,@Actual = N'sales.sales_tax_rate'
                                      ,@Message = N'Column definitions do not match';
END;
GO
