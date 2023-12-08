
CREATE OR ALTER PROCEDURE test_schema_validation.test_product_inventory__columns_match
AS
BEGIN
 
    CREATE TABLE [production].[product_inventory_tsqlt](
        [product_id] int NOT NULL
       ,[location_id] smallint NOT NULL
       ,[shelf] nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[bin] tinyint NOT NULL
       ,[quantity] smallint NOT NULL
       ,[rowguid] uniqueidentifier NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'production.product_inventory_tsqlt'
                                      ,@Actual = N'production.product_inventory'
                                      ,@Message = N'Column definitions do not match';
END;
GO
