
CREATE OR ALTER PROCEDURE test_schema_validation.test_product_model_illustration__columns_match
AS
BEGIN
 
    CREATE TABLE [production].[product_model_illustration_tsqlt](
        [product_model_id] int NOT NULL
       ,[illustration_id] int NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'production.product_model_illustration_tsqlt'
                                      ,@Actual = N'production.product_model_illustration'
                                      ,@Message = N'Column definitions do not match';
END;
GO
