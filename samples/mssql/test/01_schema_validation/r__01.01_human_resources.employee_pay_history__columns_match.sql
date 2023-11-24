
CREATE OR ALTER PROCEDURE test_schema_validation.test_employee_pay_history__columns_match
AS
BEGIN
 
    CREATE TABLE [human_resources].[employee_pay_history_tsqlt](
        [business_entity_id] int NOT NULL
       ,[rate_change_date] datetime NOT NULL
       ,[rate] money NOT NULL
       ,[pay_frequency] tinyint NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'human_resources.employee_pay_history_tsqlt'
                                      ,@Actual = N'human_resources.employee_pay_history'
                                      ,@Message = N'Column definitions do not match';
END;
GO
