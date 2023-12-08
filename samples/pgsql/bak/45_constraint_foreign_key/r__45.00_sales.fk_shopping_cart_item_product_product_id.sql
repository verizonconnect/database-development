
IF OBJECT_ID('[sales].[fk_shopping_cart_item_product_product_id]', 'F') IS NULL
BEGIN
    ALTER TABLE [sales].[shopping_cart_item]  
    ADD CONSTRAINT [fk_shopping_cart_item_product_product_id] 
    FOREIGN KEY (product_id)
    REFERENCES [production].[product] (product_id)
    ON DELETE NO ACTION;
END;
GO

ALTER TABLE [sales].[shopping_cart_item] 
CHECK CONSTRAINT [fk_shopping_cart_item_product_product_id];
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'shopping_cart_item'
                                              , N'CONSTRAINT',N'fk_shopping_cart_item_product_product_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Foreign key constraint referencing product.product_id.'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'shopping_cart_item'
                                  , @level2type=N'CONSTRAINT',@level2name=N'fk_shopping_cart_item_product_product_id'
GO
