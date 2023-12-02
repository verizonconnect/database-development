SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[human_resources].[job_candidate]') 
                      AND i.name = N'idx__human_resources__job_candidate_1_business_entity_id')
CREATE NONCLUSTERED INDEX [idx__human_resources__job_candidate_1_business_entity_id]
ON [human_resources].[job_candidate] (
 [business_entity_id] ASC
);
