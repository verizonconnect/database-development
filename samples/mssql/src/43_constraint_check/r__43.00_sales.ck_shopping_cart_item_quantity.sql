
IF OBJECT_ID('[sales].[ck_shopping_cart_item_quantity]', 'C') IS NULL
    BEGIN
        ALTER TABLE [sales].[shopping_cart_item]
        WITH NOCHECK
        ADD CONSTRAINT [ck_shopping_cart_item_quantity]
        CHECK ([quantity]>=(1));
    END;
GO

ALTER TABLE [sales].[shopping_cart_item] 
CHECK CONSTRAINT [ck_shopping_cart_item_quantity]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'shopping_cart_item'
                                              , N'CONSTRAINT',N'ck_shopping_cart_item_quantity'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [quantity] >= (1)'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'shopping_cart_item'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_shopping_cart_item_quantity'
GO
