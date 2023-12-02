SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[human_resources].[employee]') 
                      AND i.name = N'idx__human_resources__employee_4_organization_level')
CREATE NONCLUSTERED INDEX [idx__human_resources__employee_4_organization_level]
ON [human_resources].[employee] (
 [organization_level] ASC, [organization_node] ASC
);
