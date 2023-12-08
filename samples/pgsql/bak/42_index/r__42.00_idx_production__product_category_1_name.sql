SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[production].[product_category]') 
                      AND i.name = N'idx__production__product_category_1_name')
CREATE UNIQUE NONCLUSTERED INDEX [idx__production__product_category_1_name]
ON [production].[product_category] (
 [name] ASC
);
