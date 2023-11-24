
CREATE OR ALTER PROCEDURE test_schema_validation.test_email_address__columns_match
AS
BEGIN
 
    CREATE TABLE [person].[email_address_tsqlt](
        [business_entity_id] int NOT NULL
       ,[email_address_id] int NOT NULL
       ,[email_address] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
       ,[rowguid] uniqueidentifier NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'person.email_address_tsqlt'
                                      ,@Actual = N'person.email_address'
                                      ,@Message = N'Column definitions do not match';
END;
GO
