
IF OBJECT_ID('[purchasing].[ck_product_vendor_on_order_qty]', 'C') IS NULL
    BEGIN
        ALTER TABLE [purchasing].[product_vendor]
        WITH NOCHECK
        ADD CONSTRAINT [ck_product_vendor_on_order_qty]
        CHECK ([on_order_qty]>=(0));
    END;
GO

ALTER TABLE [purchasing].[product_vendor] 
CHECK CONSTRAINT [ck_product_vendor_on_order_qty]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'purchasing'
                                              , N'TABLE',N'product_vendor'
                                              , N'CONSTRAINT',N'ck_product_vendor_on_order_qty'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [on_order_qty] >= (0)'
                                  , @level0type=N'SCHEMA',@level0name=N'purchasing'
                                  , @level1type=N'TABLE',@level1name=N'product_vendor'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_product_vendor_on_order_qty'
GO
