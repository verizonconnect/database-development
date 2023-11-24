
IF OBJECT_ID('[purchasing].[ck_purchase_order_header_ship_date]', 'C') IS NULL
    BEGIN
        ALTER TABLE [purchasing].[purchase_order_header]
        WITH NOCHECK
        ADD CONSTRAINT [ck_purchase_order_header_ship_date]
        CHECK ([ship_date]>=[order_date] OR [ship_date] IS NULL);
    END;
GO

ALTER TABLE [purchasing].[purchase_order_header] 
CHECK CONSTRAINT [ck_purchase_order_header_ship_date]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'purchasing'
                                              , N'TABLE',N'purchase_order_header'
                                              , N'CONSTRAINT',N'ck_purchase_order_header_ship_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [ship_date] >= [order_date] OR [ship_date] IS NULL'
                                  , @level0type=N'SCHEMA',@level0name=N'purchasing'
                                  , @level1type=N'TABLE',@level1name=N'purchase_order_header'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_purchase_order_header_ship_date'
GO
