SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [human_resources].[set_employee__personal_info]
    @business_entity_id [int], 
    @national_id_number [nvarchar](15), 
    @birth_date [datetime], 
    @marital_status [nchar](1), 
    @gender [nchar](1)
WITH EXECUTE AS CALLER
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        UPDATE [human_resources].[employee] 
        SET [national_id_number] = @national_id_number 
            ,[birth_date] = @birth_date 
            ,[marital_status] = @marital_status 
            ,[gender] = @gender 
        WHERE [business_entity_id] = @business_entity_id;
    END TRY
    BEGIN CATCH
        EXECUTE [common].[add_log__error];
    END CATCH;
END;
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'PROCEDURE',N'set_employee__personal_info', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Updates the employee table with the values specified in the input parameters for the given employee_id.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'PROCEDURE',@level1name=N'set_employee__personal_info'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'PROCEDURE',N'set_employee__personal_info', N'PARAMETER',N'@business_entity_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Input parameter for the stored procedure set_employee__personal_info. Enter a valid business_entity_id from the human_resources.employee table.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'PROCEDURE',@level1name=N'set_employee__personal_info', @level2type=N'PARAMETER',@level2name=N'@business_entity_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'PROCEDURE',N'set_employee__personal_info', N'PARAMETER',N'@national_id_number'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Input parameter for the stored procedure set_employee__hire_info. Enter a national _id for the employee.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'PROCEDURE',@level1name=N'set_employee__personal_info', @level2type=N'PARAMETER',@level2name=N'@national_id_number'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'PROCEDURE',N'set_employee__personal_info', N'PARAMETER',N'@birth_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Input parameter for the stored procedure set_employee__hire_info. Enter a birth date for the employee.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'PROCEDURE',@level1name=N'set_employee__personal_info', @level2type=N'PARAMETER',@level2name=N'@birth_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'PROCEDURE',N'set_employee__personal_info', N'PARAMETER',N'@marital_status'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Input parameter for the stored procedure set_employee__hire_info. Enter a marital status for the employee.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'PROCEDURE',@level1name=N'set_employee__personal_info', @level2type=N'PARAMETER',@level2name=N'@marital_status'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'PROCEDURE',N'set_employee__personal_info', N'PARAMETER',N'@gender'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Input parameter for the stored procedure set_employee__hire_info. Enter a gender for the employee.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'PROCEDURE',@level1name=N'set_employee__personal_info', @level2type=N'PARAMETER',@level2name=N'@gender'
GO
