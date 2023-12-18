SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[production].[product]') 
                      AND i.name = N'idx__production__product_1_name')
CREATE UNIQUE NONCLUSTERED INDEX [idx__production__product_1_name]
ON [production].[product] (
 [name] ASC
);
