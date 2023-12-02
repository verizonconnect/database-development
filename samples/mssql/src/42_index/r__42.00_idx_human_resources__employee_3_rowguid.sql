SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[human_resources].[employee]') 
                      AND i.name = N'idx__human_resources__employee_3_rowguid')
CREATE UNIQUE NONCLUSTERED INDEX [idx__human_resources__employee_3_rowguid]
ON [human_resources].[employee] (
 [rowguid] ASC
);
