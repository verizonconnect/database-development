
CREATE OR ALTER PROCEDURE test_schema_validation.test_store__columns_match
AS
BEGIN
 
    CREATE TABLE [sales].[store_tsqlt](
        [business_entity_id] int NOT NULL
       ,[name] [common].[name] NOT NULL
       ,[sales_person_id] int NULL
       ,[demographics] xml NULL
       ,[rowguid] uniqueidentifier NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'sales.store_tsqlt'
                                      ,@Actual = N'sales.store'
                                      ,@Message = N'Column definitions do not match';
END;
GO
