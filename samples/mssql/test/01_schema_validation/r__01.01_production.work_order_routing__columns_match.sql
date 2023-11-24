
CREATE OR ALTER PROCEDURE test_schema_validation.test_work_order_routing__columns_match
AS
BEGIN
 
    CREATE TABLE [production].[work_order_routing_tsqlt](
        [work_order_id] int NOT NULL
       ,[product_id] int NOT NULL
       ,[operation_sequence] smallint NOT NULL
       ,[location_id] smallint NOT NULL
       ,[scheduled_start_date] datetime NOT NULL
       ,[scheduled_end_date] datetime NOT NULL
       ,[actual_start_date] datetime NULL
       ,[actual_end_date] datetime NULL
       ,[actual_resource_hrs] decimal(9,4) NULL
       ,[planned_cost] money NOT NULL
       ,[actual_cost] money NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'production.work_order_routing_tsqlt'
                                      ,@Actual = N'production.work_order_routing'
                                      ,@Message = N'Column definitions do not match';
END;
GO
