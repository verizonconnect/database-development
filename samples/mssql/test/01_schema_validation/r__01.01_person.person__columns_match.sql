
CREATE OR ALTER PROCEDURE test_schema_validation.test_person__columns_match
AS
BEGIN
 
    CREATE TABLE [person].[person_tsqlt](
        [business_entity_id] int NOT NULL
       ,[person_type] nchar(2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[name_style] name_style NOT NULL
       ,[title] nvarchar(8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
       ,[first_name] name NOT NULL
       ,[middle_name] name NULL
       ,[last_name] name NOT NULL
       ,[suffix] nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
       ,[email_promotion] int NOT NULL
       ,[additional_contact_info] xml NULL
       ,[demographics] xml NULL
       ,[rowguid] uniqueidentifier NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'person.person_tsqlt'
                                      ,@Actual = N'person.person'
                                      ,@Message = N'Column definitions do not match';
END;
GO
