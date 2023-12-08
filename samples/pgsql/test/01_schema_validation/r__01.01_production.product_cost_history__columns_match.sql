
CREATE OR ALTER PROCEDURE test_schema_validation.test_product_cost_history__columns_match
AS
BEGIN
 
    CREATE TABLE [production].[product_cost_history_tsqlt](
        [product_id] int NOT NULL
       ,[start_date] datetime NOT NULL
       ,[end_date] datetime NULL
       ,[standard_cost] money NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'production.product_cost_history_tsqlt'
                                      ,@Actual = N'production.product_cost_history'
                                      ,@Message = N'Column definitions do not match';
END;
GO
