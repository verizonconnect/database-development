
IF OBJECT_ID('[purchasing].[ck_purchase_order_header_tax_amt]', 'C') IS NULL
    BEGIN
        ALTER TABLE [purchasing].[purchase_order_header]
        WITH NOCHECK
        ADD CONSTRAINT [ck_purchase_order_header_tax_amt]
        CHECK ([tax_amt]>=(0.00));
    END;
GO

ALTER TABLE [purchasing].[purchase_order_header] 
CHECK CONSTRAINT [ck_purchase_order_header_tax_amt]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'purchasing'
                                              , N'TABLE',N'purchase_order_header'
                                              , N'CONSTRAINT',N'ck_purchase_order_header_tax_amt'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [tax_amt] >= (0.00)'
                                  , @level0type=N'SCHEMA',@level0name=N'purchasing'
                                  , @level1type=N'TABLE',@level1name=N'purchase_order_header'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_purchase_order_header_tax_amt'
GO
