
CREATE OR ALTER PROCEDURE test_schema_validation.test_contact_type__columns_match
AS
BEGIN
 
    CREATE TABLE [person].[contact_type_tsqlt](
        [contact_type_id] int NOT NULL
       ,[name] [common].[name] NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'person.contact_type_tsqlt'
                                      ,@Actual = N'person.contact_type'
                                      ,@Message = N'Column definitions do not match';
END;
GO
