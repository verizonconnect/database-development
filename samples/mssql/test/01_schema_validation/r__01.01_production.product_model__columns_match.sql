
CREATE OR ALTER PROCEDURE test_schema_validation.test_product_model__columns_match
AS
BEGIN
 
    CREATE TABLE [production].[product_model_tsqlt](
        [product_model_id] int NOT NULL
       ,[name] [common].[name] NOT NULL
       ,[catalog_description] xml NULL
       ,[instructions] xml NULL
       ,[rowguid] uniqueidentifier NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'production.product_model_tsqlt'
                                      ,@Actual = N'production.product_model'
                                      ,@Message = N'Column definitions do not match';
END;
GO
