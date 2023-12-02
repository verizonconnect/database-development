SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[purchasing].[purchase_order_detail]') 
                      AND i.name = N'idx__purchasing__purchase_order_detail_1_product_id')
CREATE NONCLUSTERED INDEX [idx__purchasing__purchase_order_detail_1_product_id]
ON [purchasing].[purchase_order_detail] (
 [product_id] ASC
);
