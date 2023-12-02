SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[person].[business_entity]') 
                      AND i.name = N'idx__person__business_entity_1_rowguid')
CREATE UNIQUE NONCLUSTERED INDEX [idx__person__business_entity_1_rowguid]
ON [person].[business_entity] (
 [rowguid] ASC
);
