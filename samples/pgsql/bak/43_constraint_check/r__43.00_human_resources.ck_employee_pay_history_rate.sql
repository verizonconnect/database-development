
IF OBJECT_ID('[human_resources].[ck_employee_pay_history_rate]', 'C') IS NULL
    BEGIN
        ALTER TABLE [human_resources].[employee_pay_history]
        WITH NOCHECK
        ADD CONSTRAINT [ck_employee_pay_history_rate]
        CHECK ([rate]>=(6.50) AND [rate]<=(200.00));
    END;
GO

ALTER TABLE [human_resources].[employee_pay_history] 
CHECK CONSTRAINT [ck_employee_pay_history_rate]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'human_resources'
                                              , N'TABLE',N'employee_pay_history'
                                              , N'CONSTRAINT',N'ck_employee_pay_history_rate'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [rate] >= (6.50) AND [rate] <= (200.00)'
                                  , @level0type=N'SCHEMA',@level0name=N'human_resources'
                                  , @level1type=N'TABLE',@level1name=N'employee_pay_history'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_employee_pay_history_rate'
GO
