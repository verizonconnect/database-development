
IF OBJECT_ID('[production].[ck_product_weight]', 'C') IS NULL
    BEGIN
        ALTER TABLE [production].[product]
        WITH NOCHECK
        ADD CONSTRAINT [ck_product_weight]
        CHECK ([weight]>(0.00));
    END;
GO

ALTER TABLE [production].[product] 
CHECK CONSTRAINT [ck_product_weight]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'product'
                                              , N'CONSTRAINT',N'ck_product_weight'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [weight] > (0.00)'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'product'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_product_weight'
GO
