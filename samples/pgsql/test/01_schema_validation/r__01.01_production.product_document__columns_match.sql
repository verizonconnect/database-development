
CREATE OR ALTER PROCEDURE test_schema_validation.test_product_document__columns_match
AS
BEGIN
 
    CREATE TABLE [production].[product_document_tsqlt](
        [product_id] int NOT NULL
       ,[document_node] hierarchyid NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'production.product_document_tsqlt'
                                      ,@Actual = N'production.product_document'
                                      ,@Message = N'Column definitions do not match';
END;
GO
