SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[production].[product]') 
                      AND i.name = N'idx__production__product_2_product_number')
CREATE UNIQUE NONCLUSTERED INDEX [idx__production__product_2_product_number]
ON [production].[product] (
 [product_number] ASC
);
