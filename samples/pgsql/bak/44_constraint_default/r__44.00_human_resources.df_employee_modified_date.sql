﻿
IF OBJECT_ID('[human_resources].[df_employee_modified_date]', 'D') IS NULL
    BEGIN
        ALTER TABLE [human_resources].[employee]
        ADD CONSTRAINT [df_employee_modified_date]
        DEFAULT (getdate())
        FOR [modified_date];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'human_resources'
                                              , N'TABLE',N'employee'
                                              , N'CONSTRAINT',N'df_employee_modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Default constraint value of GETDATE()'
                                  , @level0type=N'SCHEMA',@level0name=N'human_resources'
                                  , @level1type=N'TABLE',@level1name=N'employee'
                                  , @level2type=N'CONSTRAINT',@level2name=N'df_employee_modified_date'
GO
