SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[production].[document]') 
                      AND i.name = N'idx__production__document_3_file_name')
CREATE NONCLUSTERED INDEX [idx__production__document_3_file_name]
ON [production].[document] (
 [file_name] ASC, [revision] ASC
);
