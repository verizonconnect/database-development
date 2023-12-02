
CREATE OR ALTER PROCEDURE test_schema_validation.test_product_review__columns_match
AS
BEGIN
 
    CREATE TABLE [production].[product_review_tsqlt](
        [product_review_id] int NOT NULL
       ,[product_id] int NOT NULL
       ,[reviewer_name] [common].[name] NOT NULL
       ,[review_date] datetime NOT NULL
       ,[email_address] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[rating] int NOT NULL
       ,[comments] nvarchar(3850) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'production.product_review_tsqlt'
                                      ,@Actual = N'production.product_review'
                                      ,@Message = N'Column definitions do not match';
END;
GO
