SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[person].[country_region]') 
                      AND i.name = N'idx__person__country_region_1_name')
CREATE UNIQUE NONCLUSTERED INDEX [idx__person__country_region_1_name]
ON [person].[country_region] (
 [name] ASC
);
