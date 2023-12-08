SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[human_resources].[shift]') 
                      AND i.name = N'idx__human_resources__shift_2_start_time')
CREATE UNIQUE NONCLUSTERED INDEX [idx__human_resources__shift_2_start_time]
ON [human_resources].[shift] (
 [start_time] ASC, [end_time] ASC
);
