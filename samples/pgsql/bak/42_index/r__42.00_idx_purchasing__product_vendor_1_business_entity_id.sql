SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[purchasing].[product_vendor]') 
                      AND i.name = N'idx__purchasing__product_vendor_1_business_entity_id')
CREATE NONCLUSTERED INDEX [idx__purchasing__product_vendor_1_business_entity_id]
ON [purchasing].[product_vendor] (
 [business_entity_id] ASC
);
