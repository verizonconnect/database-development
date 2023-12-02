SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[person].[state_province]') 
                      AND i.name = N'idx__person__state_province_3_state_province_code')
CREATE UNIQUE NONCLUSTERED INDEX [idx__person__state_province_3_state_province_code]
ON [person].[state_province] (
 [state_province_code] ASC, [country_region_code] ASC
);
