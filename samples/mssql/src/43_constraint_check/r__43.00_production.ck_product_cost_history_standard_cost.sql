
IF OBJECT_ID('[production].[ck_product_cost_history_standard_cost]', 'C') IS NULL
    BEGIN
        ALTER TABLE [production].[product_cost_history]
        WITH NOCHECK
        ADD CONSTRAINT [ck_product_cost_history_standard_cost]
        CHECK ([standard_cost]>=(0.00));
    END;
GO

ALTER TABLE [production].[product_cost_history] 
CHECK CONSTRAINT [ck_product_cost_history_standard_cost]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'product_cost_history'
                                              , N'CONSTRAINT',N'ck_product_cost_history_standard_cost'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [standard_cost] >= (0.00)'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'product_cost_history'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_product_cost_history_standard_cost'
GO
