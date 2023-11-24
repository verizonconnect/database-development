
CREATE OR ALTER PROCEDURE test_schema_validation.test_product_photo__columns_match
AS
BEGIN
 
    CREATE TABLE [production].[product_photo_tsqlt](
        [product_photo_id] int NOT NULL
       ,[thumbnail_photo] varbinary(MAX)  NULL
       ,[thumbnail_photo_filename] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
       ,[large_photo] varbinary(MAX)  NULL
       ,[large_photo_filename] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'production.product_photo_tsqlt'
                                      ,@Actual = N'production.product_photo'
                                      ,@Message = N'Column definitions do not match';
END;
GO
