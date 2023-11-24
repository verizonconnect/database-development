
CREATE OR ALTER PROCEDURE test_schema_validation.test_sales_territory_history__columns_match
AS
BEGIN
 
    CREATE TABLE [sales].[sales_territory_history_tsqlt](
        [business_entity_id] int NOT NULL
       ,[territory_id] int NOT NULL
       ,[start_date] datetime NOT NULL
       ,[end_date] datetime NULL
       ,[rowguid] uniqueidentifier NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'sales.sales_territory_history_tsqlt'
                                      ,@Actual = N'sales.sales_territory_history'
                                      ,@Message = N'Column definitions do not match';
END;
GO
