
CREATE OR ALTER PROCEDURE test_schema_validation.test_credit_card__columns_match
AS
BEGIN
 
    CREATE TABLE [sales].[credit_card_tsqlt](
        [credit_card_id] int NOT NULL
       ,[card_type] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[card_number] nvarchar(25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[exp_month] tinyint NOT NULL
       ,[exp_year] smallint NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'sales.credit_card_tsqlt'
                                      ,@Actual = N'sales.credit_card'
                                      ,@Message = N'Column definitions do not match';
END;
GO
