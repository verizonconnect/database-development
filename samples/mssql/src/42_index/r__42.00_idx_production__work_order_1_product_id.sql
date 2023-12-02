SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[production].[work_order]') 
                      AND i.name = N'idx__production__work_order_1_product_id')
CREATE NONCLUSTERED INDEX [idx__production__work_order_1_product_id]
ON [production].[work_order] (
 [product_id] ASC
);
