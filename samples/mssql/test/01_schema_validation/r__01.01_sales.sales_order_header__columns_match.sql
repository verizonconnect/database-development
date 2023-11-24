
CREATE OR ALTER PROCEDURE test_schema_validation.test_sales_order_header__columns_match
AS
BEGIN
 
    CREATE TABLE [sales].[sales_order_header_tsqlt](
        [sales_order_id] int NOT NULL
       ,[revision_number] tinyint NOT NULL
       ,[order_date] datetime NOT NULL
       ,[due_date] datetime NOT NULL
       ,[ship_date] datetime NULL
       ,[status] tinyint NOT NULL
       ,[online_order_flag] flag NOT NULL
       ,[sales_order_number] nvarchar(25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[purchase_order_number] order_number NULL
       ,[account_number] account_number NULL
       ,[customer_id] int NOT NULL
       ,[sales_person_id] int NULL
       ,[territory_id] int NULL
       ,[bill_to_address_id] int NOT NULL
       ,[ship_to_address_id] int NOT NULL
       ,[ship_method_id] int NOT NULL
       ,[credit_card_id] int NULL
       ,[credit_card_approval_code] varchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
       ,[currency_rate_id] int NULL
       ,[sub_total] money NOT NULL
       ,[tax_amt] money NOT NULL
       ,[freight] money NOT NULL
       ,[total_due] money NOT NULL
       ,[comment] nvarchar(128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
       ,[rowguid] uniqueidentifier NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'sales.sales_order_header_tsqlt'
                                      ,@Actual = N'sales.sales_order_header'
                                      ,@Message = N'Column definitions do not match';
END;
GO
