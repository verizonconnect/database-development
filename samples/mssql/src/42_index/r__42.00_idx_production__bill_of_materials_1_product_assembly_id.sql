SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[production].[bill_of_materials]') 
                      AND i.name = N'idx__production__bill_of_materials_1_product_assembly_id')
CREATE UNIQUE NONCLUSTERED INDEX [idx__production__bill_of_materials_1_product_assembly_id]
ON [production].[bill_of_materials] (
 [product_assembly_id] ASC, [component_id] ASC, [start_date] ASC
);
