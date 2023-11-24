
CREATE OR ALTER PROCEDURE test_schema_validation.test_product_model_product_description_culture__columns_match
AS
BEGIN
 
    CREATE TABLE [production].[product_model_product_description_culture_tsqlt](
        [product_model_id] int NOT NULL
       ,[product_description_id] int NOT NULL
       ,[culture_id] nchar(6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'production.product_model_product_description_culture_tsqlt'
                                      ,@Actual = N'production.product_model_product_description_culture'
                                      ,@Message = N'Column definitions do not match';
END;
GO
