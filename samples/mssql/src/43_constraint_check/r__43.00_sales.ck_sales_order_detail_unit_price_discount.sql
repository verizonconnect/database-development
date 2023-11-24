
IF OBJECT_ID('[sales].[ck_sales_order_detail_unit_price_discount]', 'C') IS NULL
    BEGIN
        ALTER TABLE [sales].[sales_order_detail]
        WITH NOCHECK
        ADD CONSTRAINT [ck_sales_order_detail_unit_price_discount]
        CHECK ([unit_price_discount]>=(0.00));
    END;
GO

ALTER TABLE [sales].[sales_order_detail] 
CHECK CONSTRAINT [ck_sales_order_detail_unit_price_discount]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'sales_order_detail'
                                              , N'CONSTRAINT',N'ck_sales_order_detail_unit_price_discount'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [unit_price_discount] >= (0.00)'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'sales_order_detail'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_sales_order_detail_unit_price_discount'
GO
