
IF OBJECT_ID('[purchasing].[ck_purchase_order_detail_order_qty]', 'C') IS NULL
    BEGIN
        ALTER TABLE [purchasing].[purchase_order_detail]
        WITH NOCHECK
        ADD CONSTRAINT [ck_purchase_order_detail_order_qty]
        CHECK ([order_qty]>(0));
    END;
GO

ALTER TABLE [purchasing].[purchase_order_detail] 
CHECK CONSTRAINT [ck_purchase_order_detail_order_qty]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'purchasing'
                                              , N'TABLE',N'purchase_order_detail'
                                              , N'CONSTRAINT',N'ck_purchase_order_detail_order_qty'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [order_qty] > (0)'
                                  , @level0type=N'SCHEMA',@level0name=N'purchasing'
                                  , @level1type=N'TABLE',@level1name=N'purchase_order_detail'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_purchase_order_detail_order_qty'
GO
