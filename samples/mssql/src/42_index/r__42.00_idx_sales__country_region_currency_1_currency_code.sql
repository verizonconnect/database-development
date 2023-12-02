SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[sales].[country_region_currency]') 
                      AND i.name = N'idx__sales__country_region_currency_1_currency_code')
CREATE NONCLUSTERED INDEX [idx__sales__country_region_currency_1_currency_code]
ON [sales].[country_region_currency] (
 [currency_code] ASC
);
