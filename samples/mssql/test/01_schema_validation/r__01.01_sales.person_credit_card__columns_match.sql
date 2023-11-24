
CREATE OR ALTER PROCEDURE test_schema_validation.test_person_credit_card__columns_match
AS
BEGIN
 
    CREATE TABLE [sales].[person_credit_card_tsqlt](
        [business_entity_id] int NOT NULL
       ,[credit_card_id] int NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'sales.person_credit_card_tsqlt'
                                      ,@Actual = N'sales.person_credit_card'
                                      ,@Message = N'Column definitions do not match';
END;
GO
