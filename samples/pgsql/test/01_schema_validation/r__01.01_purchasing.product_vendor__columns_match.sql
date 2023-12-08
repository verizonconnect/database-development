
CREATE OR ALTER PROCEDURE test_schema_validation.test_product_vendor__columns_match
AS
BEGIN
 
    CREATE TABLE [purchasing].[product_vendor_tsqlt](
        [product_id] int NOT NULL
       ,[business_entity_id] int NOT NULL
       ,[average_lead_time] int NOT NULL
       ,[standard_price] money NOT NULL
       ,[last_receipt_cost] money NULL
       ,[last_receipt_date] datetime NULL
       ,[min_order_qty] int NOT NULL
       ,[max_order_qty] int NOT NULL
       ,[on_order_qty] int NULL
       ,[unit_measure_code] nchar(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'purchasing.product_vendor_tsqlt'
                                      ,@Actual = N'purchasing.product_vendor'
                                      ,@Message = N'Column definitions do not match';
END;
GO
