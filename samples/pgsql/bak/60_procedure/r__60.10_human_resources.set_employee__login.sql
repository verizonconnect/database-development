SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [human_resources].[set_employee__login]
    @business_entity_id [int], 
    @organization_node [hierarchyid],
    @login_id [nvarchar](256),
    @job_title [nvarchar](50),
    @hire_date [datetime],
    @current_flag [common].[flag]
WITH EXECUTE AS CALLER
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        UPDATE [human_resources].[employee] 
        SET [organization_node] = @organization_node 
            ,[login_id] = @login_id 
            ,[job_title] = @job_title 
            ,[hire_date] = @hire_date 
            ,[current_flag] = @current_flag 
        WHERE [business_entity_id] = @business_entity_id;
    END TRY
    BEGIN CATCH
        EXECUTE [common].[add_log__error];
    END CATCH;
END;
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'PROCEDURE',N'set_employee__login', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Updates the employee table with the values specified in the input parameters for the given business_entity_id.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'PROCEDURE',@level1name=N'set_employee__login'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'PROCEDURE',N'set_employee__login', N'PARAMETER',N'@business_entity_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Input parameter for the stored procedure set_employee__login. Enter a valid employee_id from the employee table.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'PROCEDURE',@level1name=N'set_employee__login', @level2type=N'PARAMETER',@level2name=N'@business_entity_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'PROCEDURE',N'set_employee__login', N'PARAMETER',N'@organization_node'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Input parameter for the stored procedure set_employee__hire_info. Enter a valid Manager_id for the employee.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'PROCEDURE',@level1name=N'set_employee__login', @level2type=N'PARAMETER',@level2name=N'@organization_node'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'PROCEDURE',N'set_employee__login', N'PARAMETER',N'@login_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Input parameter for the stored procedure set_employee__hire_info. Enter a valid login for the employee.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'PROCEDURE',@level1name=N'set_employee__login', @level2type=N'PARAMETER',@level2name=N'@login_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'PROCEDURE',N'set_employee__login', N'PARAMETER',N'@job_title'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Input parameter for the stored procedure set_employee__hire_info. Enter a title for the employee.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'PROCEDURE',@level1name=N'set_employee__login', @level2type=N'PARAMETER',@level2name=N'@job_title'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'PROCEDURE',N'set_employee__login', N'PARAMETER',N'@hire_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Input parameter for the stored procedure set_employee__hire_info. Enter a hire date for the employee.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'PROCEDURE',@level1name=N'set_employee__login', @level2type=N'PARAMETER',@level2name=N'@hire_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'PROCEDURE',N'set_employee__login', N'PARAMETER',N'@current_flag'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Input parameter for the stored procedure set_employee__hire_info. Enter the current flag for the employee.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'PROCEDURE',@level1name=N'set_employee__login', @level2type=N'PARAMETER',@level2name=N'@current_flag'
GO
