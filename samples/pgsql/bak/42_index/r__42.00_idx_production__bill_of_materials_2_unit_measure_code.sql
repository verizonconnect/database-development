SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[production].[bill_of_materials]') 
                      AND i.name = N'idx__production__bill_of_materials_2_unit_measure_code')
CREATE NONCLUSTERED INDEX [idx__production__bill_of_materials_2_unit_measure_code]
ON [production].[bill_of_materials] (
 [unit_measure_code] ASC
);
