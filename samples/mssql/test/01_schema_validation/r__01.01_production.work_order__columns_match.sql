
CREATE OR ALTER PROCEDURE test_schema_validation.test_work_order__columns_match
AS
BEGIN
 
    CREATE TABLE [production].[work_order_tsqlt](
        [work_order_id] int NOT NULL
       ,[product_id] int NOT NULL
       ,[order_qty] int NOT NULL
       ,[stocked_qty] int NOT NULL
       ,[scrapped_qty] smallint NOT NULL
       ,[start_date] datetime NOT NULL
       ,[end_date] datetime NULL
       ,[due_date] datetime NOT NULL
       ,[scrap_reason_id] smallint NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'production.work_order_tsqlt'
                                      ,@Actual = N'production.work_order'
                                      ,@Message = N'Column definitions do not match';
END;
GO
