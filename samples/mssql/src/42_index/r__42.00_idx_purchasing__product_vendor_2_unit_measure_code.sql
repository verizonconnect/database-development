SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[purchasing].[product_vendor]') 
                      AND i.name = N'idx__purchasing__product_vendor_2_unit_measure_code')
CREATE NONCLUSTERED INDEX [idx__purchasing__product_vendor_2_unit_measure_code]
ON [purchasing].[product_vendor] (
 [unit_measure_code] ASC
);
