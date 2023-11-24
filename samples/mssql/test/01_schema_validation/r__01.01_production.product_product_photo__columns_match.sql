
CREATE OR ALTER PROCEDURE test_schema_validation.test_product_product_photo__columns_match
AS
BEGIN
 
    CREATE TABLE [production].[product_product_photo_tsqlt](
        [product_id] int NOT NULL
       ,[product_photo_id] int NOT NULL
       ,[primary] flag NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'production.product_product_photo_tsqlt'
                                      ,@Actual = N'production.product_product_photo'
                                      ,@Message = N'Column definitions do not match';
END;
GO
