
IF OBJECT_ID('[purchasing].[ck_product_vendor_standard_price]', 'C') IS NULL
    BEGIN
        ALTER TABLE [purchasing].[product_vendor]
        WITH NOCHECK
        ADD CONSTRAINT [ck_product_vendor_standard_price]
        CHECK ([standard_price]>(0.00));
    END;
GO

ALTER TABLE [purchasing].[product_vendor] 
CHECK CONSTRAINT [ck_product_vendor_standard_price]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'purchasing'
                                              , N'TABLE',N'product_vendor'
                                              , N'CONSTRAINT',N'ck_product_vendor_standard_price'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [standard_price] > (0.00)'
                                  , @level0type=N'SCHEMA',@level0name=N'purchasing'
                                  , @level1type=N'TABLE',@level1name=N'product_vendor'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_product_vendor_standard_price'
GO
