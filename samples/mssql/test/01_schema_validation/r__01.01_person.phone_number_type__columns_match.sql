
CREATE OR ALTER PROCEDURE test_schema_validation.test_phone_number_type__columns_match
AS
BEGIN
 
    CREATE TABLE [person].[phone_number_type_tsqlt](
        [phone_number_type_id] int NOT NULL
       ,[name] [common].[name] NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'person.phone_number_type_tsqlt'
                                      ,@Actual = N'person.phone_number_type'
                                      ,@Message = N'Column definitions do not match';
END;
GO
