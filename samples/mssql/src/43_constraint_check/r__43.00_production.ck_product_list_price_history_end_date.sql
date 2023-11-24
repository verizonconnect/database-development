
IF OBJECT_ID('[production].[ck_product_list_price_history_end_date]', 'C') IS NULL
    BEGIN
        ALTER TABLE [production].[product_list_price_history]
        WITH NOCHECK
        ADD CONSTRAINT [ck_product_list_price_history_end_date]
        CHECK ([end_date]>=[start_date] OR [end_date] IS NULL);
    END;
GO

ALTER TABLE [production].[product_list_price_history] 
CHECK CONSTRAINT [ck_product_list_price_history_end_date]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'product_list_price_history'
                                              , N'CONSTRAINT',N'ck_product_list_price_history_end_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [end_date] >= [start_date] OR [end_date] IS NULL'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'product_list_price_history'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_product_list_price_history_end_date'
GO
