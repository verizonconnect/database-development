
CREATE OR ALTER PROCEDURE test_schema_validation.test_employee__columns_match
AS
BEGIN
 
    CREATE TABLE [human_resources].[employee_tsqlt](
        [business_entity_id] int NOT NULL
       ,[national_id_number] nvarchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[login_id] nvarchar(256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[organization_node] hierarchyid NULL
       ,[organization_level] smallint NULL
       ,[job_title] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[birth_date] date NOT NULL
       ,[marital_status] nchar(1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[gender] nchar(1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[hire_date] date NOT NULL
       ,[salaried_flag] flag NOT NULL
       ,[holiday_hours] smallint NOT NULL
       ,[sick_leave_hours] smallint NOT NULL
       ,[current_flag] flag NOT NULL
       ,[rowguid] uniqueidentifier NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'human_resources.employee_tsqlt'
                                      ,@Actual = N'human_resources.employee'
                                      ,@Message = N'Column definitions do not match';
END;
GO
