
CREATE OR ALTER PROCEDURE test_schema_validation.test_employee_department_history__columns_match
AS
BEGIN
 
    CREATE TABLE [human_resources].[employee_department_history_tsqlt](
        [business_entity_id] int NOT NULL
       ,[department_id] smallint NOT NULL
       ,[shift_id] tinyint NOT NULL
       ,[start_date] date NOT NULL
       ,[end_date] date NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'human_resources.employee_department_history_tsqlt'
                                      ,@Actual = N'human_resources.employee_department_history'
                                      ,@Message = N'Column definitions do not match';
END;
GO
