SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[sales].[sales_tax_rate]') 
                      AND i.name = N'idx__sales__sales_tax_rate_2_state_province_id')
CREATE UNIQUE NONCLUSTERED INDEX [idx__sales__sales_tax_rate_2_state_province_id]
ON [sales].[sales_tax_rate] (
 [state_province_id] ASC, [tax_type] ASC
);
