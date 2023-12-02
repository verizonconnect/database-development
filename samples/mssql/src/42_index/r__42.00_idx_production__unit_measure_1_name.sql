SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[production].[unit_measure]') 
                      AND i.name = N'idx__production__unit_measure_1_name')
CREATE UNIQUE NONCLUSTERED INDEX [idx__production__unit_measure_1_name]
ON [production].[unit_measure] (
 [name] ASC
);
