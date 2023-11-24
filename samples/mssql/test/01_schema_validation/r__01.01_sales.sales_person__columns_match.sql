
CREATE OR ALTER PROCEDURE test_schema_validation.test_sales_person__columns_match
AS
BEGIN
 
    CREATE TABLE [sales].[sales_person_tsqlt](
        [business_entity_id] int NOT NULL
       ,[territory_id] int NULL
       ,[sales_quota] money NULL
       ,[bonus] money NOT NULL
       ,[commission_pct] smallmoney NOT NULL
       ,[sales_ytd] money NOT NULL
       ,[sales_last_year] money NOT NULL
       ,[rowguid] uniqueidentifier NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'sales.sales_person_tsqlt'
                                      ,@Actual = N'sales.sales_person'
                                      ,@Message = N'Column definitions do not match';
END;
GO
