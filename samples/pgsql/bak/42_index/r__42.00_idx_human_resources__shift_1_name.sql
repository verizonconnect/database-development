SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[human_resources].[shift]') 
                      AND i.name = N'idx__human_resources__shift_1_name')
CREATE UNIQUE NONCLUSTERED INDEX [idx__human_resources__shift_1_name]
ON [human_resources].[shift] (
 [name] ASC
);
