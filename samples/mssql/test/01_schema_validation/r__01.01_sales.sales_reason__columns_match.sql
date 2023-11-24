
CREATE OR ALTER PROCEDURE test_schema_validation.test_sales_reason__columns_match
AS
BEGIN
 
    CREATE TABLE [sales].[sales_reason_tsqlt](
        [sales_reason_id] int NOT NULL
       ,[name] [common].[name] NOT NULL
       ,[reason_type] name NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'sales.sales_reason_tsqlt'
                                      ,@Actual = N'sales.sales_reason'
                                      ,@Message = N'Column definitions do not match';
END;
GO
