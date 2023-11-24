
CREATE OR ALTER PROCEDURE test_schema_validation.test_department__columns_match
AS
BEGIN
 
    CREATE TABLE [human_resources].[department_tsqlt](
        [department_id] smallint NOT NULL
       ,[name] [common].[name] NOT NULL
       ,[group_name] name NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'human_resources.department_tsqlt'
                                      ,@Actual = N'human_resources.department'
                                      ,@Message = N'Column definitions do not match';
END;
GO
