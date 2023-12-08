
IF OBJECT_ID('[human_resources].[ck_employee_gender]', 'C') IS NULL
    BEGIN
        ALTER TABLE [human_resources].[employee]
        WITH NOCHECK
        ADD CONSTRAINT [ck_employee_gender]
        CHECK (upper([gender])='F' OR upper([gender])='M');
    END;
GO

ALTER TABLE [human_resources].[employee] 
CHECK CONSTRAINT [ck_employee_gender]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'human_resources'
                                              , N'TABLE',N'employee'
                                              , N'CONSTRAINT',N'ck_employee_gender'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [gender]=''f'' OR [gender]=''m'' OR [gender]=''F'' OR [gender]=''M'''
                                  , @level0type=N'SCHEMA',@level0name=N'human_resources'
                                  , @level1type=N'TABLE',@level1name=N'employee'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_employee_gender'
GO
