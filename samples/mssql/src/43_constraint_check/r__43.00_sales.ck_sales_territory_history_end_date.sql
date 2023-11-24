
IF OBJECT_ID('[sales].[ck_sales_territory_history_end_date]', 'C') IS NULL
    BEGIN
        ALTER TABLE [sales].[sales_territory_history]
        WITH NOCHECK
        ADD CONSTRAINT [ck_sales_territory_history_end_date]
        CHECK ([end_date]>=[start_date] OR [end_date] IS NULL);
    END;
GO

ALTER TABLE [sales].[sales_territory_history] 
CHECK CONSTRAINT [ck_sales_territory_history_end_date]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'sales_territory_history'
                                              , N'CONSTRAINT',N'ck_sales_territory_history_end_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [end_date] >= [start_date] OR [end_date] IS NULL'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'sales_territory_history'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_sales_territory_history_end_date'
GO
