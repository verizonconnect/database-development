
CREATE OR ALTER PROCEDURE test_schema_validation.test_password__columns_match
AS
BEGIN
 
    CREATE TABLE [person].[password_tsqlt](
        [business_entity_id] int NOT NULL
       ,[password_hash] varchar(128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[password_salt] varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[rowguid] uniqueidentifier NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'person.password_tsqlt'
                                      ,@Actual = N'person.password'
                                      ,@Message = N'Column definitions do not match';
END;
GO
