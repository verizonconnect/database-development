
CREATE OR ALTER PROCEDURE test_schema_validation.test_product_sub_category__columns_match
AS
BEGIN
 
    CREATE TABLE [production].[product_sub_category_tsqlt](
        [product_sub_category_id] int NOT NULL
       ,[product_category_id] int NOT NULL
       ,[name] [common].[name] NOT NULL
       ,[rowguid] uniqueidentifier NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'production.product_sub_category_tsqlt'
                                      ,@Actual = N'production.product_sub_category'
                                      ,@Message = N'Column definitions do not match';
END;
GO
