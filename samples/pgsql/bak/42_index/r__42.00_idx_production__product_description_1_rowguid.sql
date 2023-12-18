SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[production].[product_description]') 
                      AND i.name = N'idx__production__product_description_1_rowguid')
CREATE UNIQUE NONCLUSTERED INDEX [idx__production__product_description_1_rowguid]
ON [production].[product_description] (
 [rowguid] ASC
);
