
CREATE OR ALTER PROCEDURE test_schema_validation.test_business_entity__columns_match
AS
BEGIN
 
    CREATE TABLE [person].[business_entity_tsqlt](
        [business_entity_id] int NOT NULL
       ,[rowguid] uniqueidentifier NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'person.business_entity_tsqlt'
                                      ,@Actual = N'person.business_entity'
                                      ,@Message = N'Column definitions do not match';
END;
GO
