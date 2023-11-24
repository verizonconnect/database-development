
CREATE OR ALTER PROCEDURE test_schema_validation.test_sales_person_quota_history__columns_match
AS
BEGIN
 
    CREATE TABLE [sales].[sales_person_quota_history_tsqlt](
        [business_entity_id] int NOT NULL
       ,[quota_date] datetime NOT NULL
       ,[sales_quota] money NOT NULL
       ,[rowguid] uniqueidentifier NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'sales.sales_person_quota_history_tsqlt'
                                      ,@Actual = N'sales.sales_person_quota_history'
                                      ,@Message = N'Column definitions do not match';
END;
GO
