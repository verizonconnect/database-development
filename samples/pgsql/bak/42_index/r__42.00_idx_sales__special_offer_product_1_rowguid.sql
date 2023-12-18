SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[sales].[special_offer_product]') 
                      AND i.name = N'idx__sales__special_offer_product_1_rowguid')
CREATE UNIQUE NONCLUSTERED INDEX [idx__sales__special_offer_product_1_rowguid]
ON [sales].[special_offer_product] (
 [rowguid] ASC
);
