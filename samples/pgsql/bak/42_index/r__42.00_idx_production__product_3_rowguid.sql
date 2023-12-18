SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[production].[product]') 
                      AND i.name = N'idx__production__product_3_rowguid')
CREATE UNIQUE NONCLUSTERED INDEX [idx__production__product_3_rowguid]
ON [production].[product] (
 [rowguid] ASC
);
