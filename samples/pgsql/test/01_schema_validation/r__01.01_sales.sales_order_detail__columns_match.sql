
CREATE OR ALTER PROCEDURE test_schema_validation.test_sales_order_detail__columns_match
AS
BEGIN
 
    CREATE TABLE [sales].[sales_order_detail_tsqlt](
        [sales_order_id] int NOT NULL
       ,[sales_order_detail_id] int NOT NULL
       ,[carrier_tracking_number] nvarchar(25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
       ,[order_qty] smallint NOT NULL
       ,[product_id] int NOT NULL
       ,[special_offer_id] int NOT NULL
       ,[unit_price] money NOT NULL
       ,[unit_price_discount] money NOT NULL
       ,[line_total] numeric(38,6) NOT NULL
       ,[rowguid] uniqueidentifier NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'sales.sales_order_detail_tsqlt'
                                      ,@Actual = N'sales.sales_order_detail'
                                      ,@Message = N'Column definitions do not match';
END;
GO
