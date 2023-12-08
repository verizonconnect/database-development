SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[production].[document]') 
                      AND i.name = N'idx__production__document_1_document_level')
CREATE UNIQUE NONCLUSTERED INDEX [idx__production__document_1_document_level]
ON [production].[document] (
 [document_level] ASC, [document_node] ASC
);
