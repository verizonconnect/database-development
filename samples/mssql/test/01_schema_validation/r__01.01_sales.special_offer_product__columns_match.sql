
CREATE OR ALTER PROCEDURE test_schema_validation.test_special_offer_product__columns_match
AS
BEGIN
 
    CREATE TABLE [sales].[special_offer_product_tsqlt](
        [special_offer_id] int NOT NULL
       ,[product_id] int NOT NULL
       ,[rowguid] uniqueidentifier NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'sales.special_offer_product_tsqlt'
                                      ,@Actual = N'sales.special_offer_product'
                                      ,@Message = N'Column definitions do not match';
END;
GO
