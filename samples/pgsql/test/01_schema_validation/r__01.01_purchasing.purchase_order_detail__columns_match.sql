
CREATE OR ALTER PROCEDURE test_schema_validation.test_purchase_order_detail__columns_match
AS
BEGIN
 
    CREATE TABLE [purchasing].[purchase_order_detail_tsqlt](
        [purchase_order_id] int NOT NULL
       ,[purchase_order_detail_id] int NOT NULL
       ,[due_date] datetime NOT NULL
       ,[order_qty] smallint NOT NULL
       ,[product_id] int NOT NULL
       ,[unit_price] money NOT NULL
       ,[line_total] money NOT NULL
       ,[received_qty] decimal(8,2) NOT NULL
       ,[rejected_qty] decimal(8,2) NOT NULL
       ,[stocked_qty] decimal(9,2) NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'purchasing.purchase_order_detail_tsqlt'
                                      ,@Actual = N'purchasing.purchase_order_detail'
                                      ,@Message = N'Column definitions do not match';
END;
GO
