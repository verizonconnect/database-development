
IF OBJECT_ID('[sales].[df_sales_order_detail_unit_price_discount]', 'D') IS NULL
    BEGIN
        ALTER TABLE [sales].[sales_order_detail]
        ADD CONSTRAINT [df_sales_order_detail_unit_price_discount]
        DEFAULT ((0.0))
        FOR [unit_price_discount];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'sales_order_detail'
                                              , N'CONSTRAINT',N'df_sales_order_detail_unit_price_discount'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Default constraint value of 0.0'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'sales_order_detail'
                                  , @level2type=N'CONSTRAINT',@level2name=N'df_sales_order_detail_unit_price_discount'
GO
