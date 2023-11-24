
IF OBJECT_ID('[human_resources].[ck_employee_marital_status]', 'C') IS NULL
    BEGIN
        ALTER TABLE [human_resources].[employee]
        WITH NOCHECK
        ADD CONSTRAINT [ck_employee_marital_status]
        CHECK (upper([marital_status])='S' OR upper([marital_status])='M');
    END;
GO

ALTER TABLE [human_resources].[employee] 
CHECK CONSTRAINT [ck_employee_marital_status]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'human_resources'
                                              , N'TABLE',N'employee'
                                              , N'CONSTRAINT',N'ck_employee_marital_status'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [marital_status]=''s'' OR [marital_status]=''m'' OR [marital_status]=''S'' OR [marital_status]=''M'''
                                  , @level0type=N'SCHEMA',@level0name=N'human_resources'
                                  , @level1type=N'TABLE',@level1name=N'employee'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_employee_marital_status'
GO
