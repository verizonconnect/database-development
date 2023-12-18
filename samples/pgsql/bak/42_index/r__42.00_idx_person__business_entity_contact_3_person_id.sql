SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[person].[business_entity_contact]') 
                      AND i.name = N'idx__person__business_entity_contact_3_person_id')
CREATE NONCLUSTERED INDEX [idx__person__business_entity_contact_3_person_id]
ON [person].[business_entity_contact] (
 [person_id] ASC
);
