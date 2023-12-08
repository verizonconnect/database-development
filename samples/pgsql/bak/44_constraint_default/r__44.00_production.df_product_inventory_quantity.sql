
IF OBJECT_ID('[production].[df_product_inventory_quantity]', 'D') IS NULL
    BEGIN
        ALTER TABLE [production].[product_inventory]
        ADD CONSTRAINT [df_product_inventory_quantity]
        DEFAULT ((0))
        FOR [quantity];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'product_inventory'
                                              , N'CONSTRAINT',N'df_product_inventory_quantity'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Default constraint value of 0'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'product_inventory'
                                  , @level2type=N'CONSTRAINT',@level2name=N'df_product_inventory_quantity'
GO
