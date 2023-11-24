
CREATE OR ALTER PROCEDURE test_schema_validation.test_sales_territory__columns_match
AS
BEGIN
 
    CREATE TABLE [sales].[sales_territory_tsqlt](
        [territory_id] int NOT NULL
       ,[name] [common].[name] NOT NULL
       ,[country_region_code] nvarchar(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[group] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[sales_ytd] money NOT NULL
       ,[sales_last_year] money NOT NULL
       ,[cost_ytd] money NOT NULL
       ,[cost_last_year] money NOT NULL
       ,[rowguid] uniqueidentifier NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'sales.sales_territory_tsqlt'
                                      ,@Actual = N'sales.sales_territory'
                                      ,@Message = N'Column definitions do not match';
END;
GO
