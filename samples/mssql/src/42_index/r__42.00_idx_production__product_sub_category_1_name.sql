SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[production].[product_sub_category]') 
                      AND i.name = N'idx__production__product_sub_category_1_name')
CREATE UNIQUE NONCLUSTERED INDEX [idx__production__product_sub_category_1_name]
ON [production].[product_sub_category] (
 [name] ASC
);
