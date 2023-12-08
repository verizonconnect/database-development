
CREATE OR ALTER PROCEDURE test_schema_validation.test_shopping_cart_item__columns_match
AS
BEGIN
 
    CREATE TABLE [sales].[shopping_cart_item_tsqlt](
        [shopping_cart_item_id] int NOT NULL
       ,[shopping_cart_id] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[quantity] int NOT NULL
       ,[product_id] int NOT NULL
       ,[created_date] datetime NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'sales.shopping_cart_item_tsqlt'
                                      ,@Actual = N'sales.shopping_cart_item'
                                      ,@Message = N'Column definitions do not match';
END;
GO
