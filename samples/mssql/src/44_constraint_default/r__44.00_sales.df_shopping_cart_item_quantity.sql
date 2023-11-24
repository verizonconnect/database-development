
IF OBJECT_ID('[sales].[df_shopping_cart_item_quantity]', 'D') IS NULL
    BEGIN
        ALTER TABLE [sales].[shopping_cart_item]
        ADD CONSTRAINT [df_shopping_cart_item_quantity]
        DEFAULT ((1))
        FOR [quantity];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'shopping_cart_item'
                                              , N'CONSTRAINT',N'df_shopping_cart_item_quantity'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Default constraint value of 1'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'shopping_cart_item'
                                  , @level2type=N'CONSTRAINT',@level2name=N'df_shopping_cart_item_quantity'
GO
