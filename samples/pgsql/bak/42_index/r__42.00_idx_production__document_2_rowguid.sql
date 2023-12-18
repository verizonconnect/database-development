SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[production].[document]') 
                      AND i.name = N'idx__production__document_2_rowguid')
CREATE UNIQUE NONCLUSTERED INDEX [idx__production__document_2_rowguid]
ON [production].[document] (
 [rowguid] ASC
);
