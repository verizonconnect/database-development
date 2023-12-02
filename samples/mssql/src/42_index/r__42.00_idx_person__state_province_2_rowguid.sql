SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[person].[state_province]') 
                      AND i.name = N'idx__person__state_province_2_rowguid')
CREATE UNIQUE NONCLUSTERED INDEX [idx__person__state_province_2_rowguid]
ON [person].[state_province] (
 [rowguid] ASC
);
