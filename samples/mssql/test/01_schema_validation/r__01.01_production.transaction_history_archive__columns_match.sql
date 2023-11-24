
CREATE OR ALTER PROCEDURE test_schema_validation.test_transaction_history_archive__columns_match
AS
BEGIN
 
    CREATE TABLE [production].[transaction_history_archive_tsqlt](
        [transaction_id] int NOT NULL
       ,[product_id] int NOT NULL
       ,[reference_order_id] int NOT NULL
       ,[reference_order_line_id] int NOT NULL
       ,[transaction_date] datetime NOT NULL
       ,[transaction_type] nchar(1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[quantity] int NOT NULL
       ,[actual_cost] money NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'production.transaction_history_archive_tsqlt'
                                      ,@Actual = N'production.transaction_history_archive'
                                      ,@Message = N'Column definitions do not match';
END;
GO
