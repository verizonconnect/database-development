SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[sales].[currency_rate]') 
                      AND i.name = N'idx__sales__currency_rate_1_currency_rate_date')
CREATE UNIQUE NONCLUSTERED INDEX [idx__sales__currency_rate_1_currency_rate_date]
ON [sales].[currency_rate] (
 [currency_rate_date] ASC, [from_currency_code] ASC, [to_currency_code] ASC
);
