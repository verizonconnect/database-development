
CREATE OR ALTER PROCEDURE test_schema_validation.test_special_offer__columns_match
AS
BEGIN
 
    CREATE TABLE [sales].[special_offer_tsqlt](
        [special_offer_id] int NOT NULL
       ,[description] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[discount_pct] smallmoney NOT NULL
       ,[type] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[category] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[start_date] datetime NOT NULL
       ,[end_date] datetime NOT NULL
       ,[min_qty] int NOT NULL
       ,[max_qty] int NULL
       ,[rowguid] uniqueidentifier NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'sales.special_offer_tsqlt'
                                      ,@Actual = N'sales.special_offer'
                                      ,@Message = N'Column definitions do not match';
END;
GO
