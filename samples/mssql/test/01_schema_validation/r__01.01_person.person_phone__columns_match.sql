
CREATE OR ALTER PROCEDURE test_schema_validation.test_person_phone__columns_match
AS
BEGIN
 
    CREATE TABLE [person].[person_phone_tsqlt](
        [business_entity_id] int NOT NULL
       ,[phone_number] [common].[phone] NOT NULL
       ,[phone_number_type_id] int NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'person.person_phone_tsqlt'
                                      ,@Actual = N'person.person_phone'
                                      ,@Message = N'Column definitions do not match';
END;
GO
