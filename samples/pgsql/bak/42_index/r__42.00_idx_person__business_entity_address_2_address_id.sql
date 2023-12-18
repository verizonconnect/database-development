SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[person].[business_entity_address]') 
                      AND i.name = N'idx__person__business_entity_address_2_address_id')
CREATE NONCLUSTERED INDEX [idx__person__business_entity_address_2_address_id]
ON [person].[business_entity_address] (
 [address_id] ASC
);
