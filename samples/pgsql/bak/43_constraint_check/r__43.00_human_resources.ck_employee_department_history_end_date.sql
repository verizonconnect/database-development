
IF OBJECT_ID('[human_resources].[ck_employee_department_history_end_date]', 'C') IS NULL
    BEGIN
        ALTER TABLE [human_resources].[employee_department_history]
        WITH NOCHECK
        ADD CONSTRAINT [ck_employee_department_history_end_date]
        CHECK ([end_date]>=[start_date] OR [end_date] IS NULL);
    END;
GO

ALTER TABLE [human_resources].[employee_department_history] 
CHECK CONSTRAINT [ck_employee_department_history_end_date]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'human_resources'
                                              , N'TABLE',N'employee_department_history'
                                              , N'CONSTRAINT',N'ck_employee_department_history_end_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [end_date] >= [start_date] OR [end_date] IS NUL'
                                  , @level0type=N'SCHEMA',@level0name=N'human_resources'
                                  , @level1type=N'TABLE',@level1name=N'employee_department_history'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_employee_department_history_end_date'
GO
