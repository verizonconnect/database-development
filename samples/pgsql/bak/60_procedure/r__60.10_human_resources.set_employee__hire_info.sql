SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [human_resources].[set_employee__hire_info]
    @business_entity_id [int], 
    @job_title [nvarchar](50), 
    @hire_date [datetime], 
    @rate_change_date [datetime], 
    @rate [money], 
    @pay_frequency [tinyint], 
    @current_flag [common].[flag] 
WITH EXECUTE AS CALLER
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE [human_resources].[employee] 
        SET [job_title] = @job_title 
            ,[hire_date] = @hire_date 
            ,[current_flag] = @current_flag 
        WHERE [business_entity_id] = @business_entity_id;

        INSERT INTO [human_resources].[employee_pay_history] 
            ([business_entity_id]
            ,[rate_change_date]
            ,[rate]
            ,[pay_frequency]) 
        VALUES (@business_entity_id, @rate_change_date, @rate, @pay_frequency);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Rollback any active or uncommittable transactions before
        -- inserting information in the error_log
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END

        EXECUTE [common].[add_log__error];
    END CATCH;
END;
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'PROCEDURE',N'set_employee__hire_info', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Updates the employee table and inserts a new row in the employee_pay_history table with the values specified in the input parameters.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'PROCEDURE',@level1name=N'set_employee__hire_info'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'PROCEDURE',N'set_employee__hire_info', N'PARAMETER',N'@business_entity_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Input parameter for the stored procedure set_employee__hire_info. Enter a valid business_entity_id from the employee table.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'PROCEDURE',@level1name=N'set_employee__hire_info', @level2type=N'PARAMETER',@level2name=N'@business_entity_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'PROCEDURE',N'set_employee__hire_info', N'PARAMETER',N'@job_title'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Input parameter for the stored procedure set_employee__hire_info. Enter a title for the employee.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'PROCEDURE',@level1name=N'set_employee__hire_info', @level2type=N'PARAMETER',@level2name=N'@job_title'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'PROCEDURE',N'set_employee__hire_info', N'PARAMETER',N'@hire_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Input parameter for the stored procedure set_employee__hire_info. Enter a hire date for the employee.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'PROCEDURE',@level1name=N'set_employee__hire_info', @level2type=N'PARAMETER',@level2name=N'@hire_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'PROCEDURE',N'set_employee__hire_info', N'PARAMETER',N'@rate_change_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Input parameter for the stored procedure set_employee__hire_info. Enter the date the rate changed for the employee.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'PROCEDURE',@level1name=N'set_employee__hire_info', @level2type=N'PARAMETER',@level2name=N'@rate_change_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'PROCEDURE',N'set_employee__hire_info', N'PARAMETER',N'@rate'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Input parameter for the stored procedure set_employee__hire_info. Enter the new rate for the employee.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'PROCEDURE',@level1name=N'set_employee__hire_info', @level2type=N'PARAMETER',@level2name=N'@rate'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'PROCEDURE',N'set_employee__hire_info', N'PARAMETER',N'@pay_frequency'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Input parameter for the stored procedure set_employee__hire_info. Enter the pay frequency for the employee.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'PROCEDURE',@level1name=N'set_employee__hire_info', @level2type=N'PARAMETER',@level2name=N'@pay_frequency'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'PROCEDURE',N'set_employee__hire_info', N'PARAMETER',N'@current_flag'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Input parameter for the stored procedure set_employee__hire_info. Enter the current flag for the employee.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'PROCEDURE',@level1name=N'set_employee__hire_info', @level2type=N'PARAMETER',@level2name=N'@current_flag'
GO
