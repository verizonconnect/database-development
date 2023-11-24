
IF OBJECT_ID('[sales].[ck_sales_person_quota_history_sales_quota]', 'C') IS NULL
    BEGIN
        ALTER TABLE [sales].[sales_person_quota_history]
        WITH NOCHECK
        ADD CONSTRAINT [ck_sales_person_quota_history_sales_quota]
        CHECK ([sales_quota]>(0.00));
    END;
GO

ALTER TABLE [sales].[sales_person_quota_history] 
CHECK CONSTRAINT [ck_sales_person_quota_history_sales_quota]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'sales_person_quota_history'
                                              , N'CONSTRAINT',N'ck_sales_person_quota_history_sales_quota'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [sales_quota] > (0.00)'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'sales_person_quota_history'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_sales_person_quota_history_sales_quota'
GO
