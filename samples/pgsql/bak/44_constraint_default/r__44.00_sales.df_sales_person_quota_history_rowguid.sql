
IF OBJECT_ID('[sales].[df_sales_person_quota_history_rowguid]', 'D') IS NULL
    BEGIN
        ALTER TABLE [sales].[sales_person_quota_history]
        ADD CONSTRAINT [df_sales_person_quota_history_rowguid]
        DEFAULT (newid())
        FOR [rowguid];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'sales_person_quota_history'
                                              , N'CONSTRAINT',N'df_sales_person_quota_history_rowguid'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Default constraint value of NEW_id()'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'sales_person_quota_history'
                                  , @level2type=N'CONSTRAINT',@level2name=N'df_sales_person_quota_history_rowguid'
GO
