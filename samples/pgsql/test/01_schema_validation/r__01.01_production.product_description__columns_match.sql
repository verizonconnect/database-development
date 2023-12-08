
CREATE OR ALTER PROCEDURE test_schema_validation.test_product_description__columns_match
AS
BEGIN
 
    CREATE TABLE [production].[product_description_tsqlt](
        [product_description_id] int NOT NULL
       ,[description] nvarchar(400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[rowguid] uniqueidentifier NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'production.product_description_tsqlt'
                                      ,@Actual = N'production.product_description'
                                      ,@Message = N'Column definitions do not match';
END;
GO
