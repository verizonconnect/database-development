SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[sales].[shopping_cart_item]') 
                      AND i.name = N'idx__sales__shopping_cart_item_1_shopping_cart_id')
CREATE NONCLUSTERED INDEX [idx__sales__shopping_cart_item_1_shopping_cart_id]
ON [sales].[shopping_cart_item] (
 [shopping_cart_id] ASC, [product_id] ASC
);
