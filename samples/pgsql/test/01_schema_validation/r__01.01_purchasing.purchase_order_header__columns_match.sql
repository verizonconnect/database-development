
CREATE OR ALTER PROCEDURE test_schema_validation.test_purchase_order_header__columns_match
AS
BEGIN
 
    CREATE TABLE [purchasing].[purchase_order_header_tsqlt](
        [purchase_order_id] int NOT NULL
       ,[revision_number] tinyint NOT NULL
       ,[status] tinyint NOT NULL
       ,[employee_id] int NOT NULL
       ,[vendor_id] int NOT NULL
       ,[ship_method_id] int NOT NULL
       ,[order_date] datetime NOT NULL
       ,[ship_date] datetime NULL
       ,[sub_total] money NOT NULL
       ,[tax_amt] money NOT NULL
       ,[freight] money NOT NULL
       ,[total_due] money NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'purchasing.purchase_order_header_tsqlt'
                                      ,@Actual = N'purchasing.purchase_order_header'
                                      ,@Message = N'Column definitions do not match';
END;
GO
