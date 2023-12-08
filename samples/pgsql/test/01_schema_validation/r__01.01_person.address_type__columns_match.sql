
CREATE OR ALTER PROCEDURE test_schema_validation.test_address_type__columns_match
AS
BEGIN
 
    CREATE TABLE [person].[address_type_tsqlt](
        [address_type_id] int NOT NULL
       ,[name] [common].[name] NOT NULL
       ,[rowguid] uniqueidentifier NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'person.address_type_tsqlt'
                                      ,@Actual = N'person.address_type'
                                      ,@Message = N'Column definitions do not match';
END;
GO
