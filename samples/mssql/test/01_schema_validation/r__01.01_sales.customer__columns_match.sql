
CREATE OR ALTER PROCEDURE test_schema_validation.test_customer__columns_match
AS
BEGIN
 
    CREATE TABLE [sales].[customer_tsqlt](
        [customer_id] int NOT NULL
       ,[person_id] int NULL
       ,[store_id] int NULL
       ,[territory_id] int NULL
       ,[account_number] varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[rowguid] uniqueidentifier NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'sales.customer_tsqlt'
                                      ,@Actual = N'sales.customer'
                                      ,@Message = N'Column definitions do not match';
END;
GO
