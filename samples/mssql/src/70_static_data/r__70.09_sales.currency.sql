--User defined type ([common].[name]) means we cannot just use using CREATE TABLE
SELECT  TOP (0)
        [currency_code]
       ,[name]
INTO    #currency
FROM    sales.currency;

INSERT INTO #currency (
    [currency_code]
   ,[name]
)
VALUES  ('AED','Emirati Dirham')
       ,('AFA','Afghani')
       ,('ALL','Lek')
       ,('AMD','Armenian Dram')
       ,('ANG','Netherlands Antillian Guilder')
       ,('AOA','Kwanza')
       ,('ARS','Argentine Peso')
       ,('ATS','Shilling')
       ,('AUD','Australian Dollar')
       ,('AWG','Aruban Guilder')
       ,('AZM','Azerbaijanian Manat')
       ,('BBD','Barbados Dollar')
       ,('BDT','Taka')
       ,('BEF','Belgian Franc')
       ,('BGN','Bulgarian Lev')
       ,('BHD','Bahraini Dinar')
       ,('BND','Brunei Dollar')
       ,('BOB','Boliviano')
       ,('BRL','Brazilian Real')
       ,('BSD','Bahamian Dollar')
       ,('BTN','Ngultrum')
       ,('CAD','Canadian Dollar')
       ,('CHF','Swiss Franc')
       ,('CLP','Chilean Peso')
       ,('CNY','Yuan Renminbi')
       ,('COP','Colombian Peso')
       ,('CRC','Costa Rican Colon')
       ,('CYP','Cyprus Pound')
       ,('CZK','Czech Koruna')
       ,('DEM','Deutsche Mark')
       ,('DKK','Danish Krone')
       ,('DOP','Dominican Peso')
       ,('DZD','Algerian Dinar')
       ,('EEK','Kroon')
       ,('EGP','Egyptian Pound')
       ,('ESP','Spanish Peseta')
       ,('EUR','EURO')
       ,('FIM','Markka')
       ,('FJD','Fiji Dollar')
       ,('FRF','French Franc')
       ,('GBP','United Kingdom Pound')
       ,('GHC','Cedi')
       ,('GRD','Drachma')
       ,('GTQ','Quetzal')
       ,('HKD','Hong Kong Dollar')
       ,('HRK','Croatian Kuna')
       ,('HUF','Forint')
       ,('IDR','Rupiah')
       ,('IEP','Irish Pound')
       ,('ILS','New Israeli Shekel')
       ,('INR','Indian Rupee')
       ,('ISK','Iceland Krona')
       ,('ITL','Italian Lira')
       ,('JMD','Jamaican Dollar')
       ,('JOD','Jordanian Dinar')
       ,('JPY','Yen')
       ,('KES','Kenyan Shilling')
       ,('KRW','Won')
       ,('KWD','Kuwaiti Dinar')
       ,('LBP','Lebanese Pound')
       ,('LKR','Sri Lankan Rupee')
       ,('LTL','Lithuanian Litas')
       ,('LVL','Latvian Lats')
       ,('MAD','Moroccan Dirham')
       ,('MTL','Maltese Lira')
       ,('MUR','Mauritius Rupee')
       ,('MVR','Rufiyaa')
       ,('MXN','Mexican Peso')
       ,('MYR','Malaysian Ringgit')
       ,('NAD','Namibia Dollar')
       ,('NGN','Naira')
       ,('NLG','Netherlands Guilder')
       ,('NOK','Norwegian Krone')
       ,('NPR','Nepalese Rupee')
       ,('NZD','New Zealand Dollar')
       ,('OMR','Omani Rial')
       ,('PAB','Balboa')
       ,('PEN','Nuevo Sol')
       ,('PHP','Philippine Peso')
       ,('PKR','Pakistan Rupee')
       ,('PLN','Zloty')
       ,('PLZ','Polish Zloty(old)')
       ,('PTE','Portuguese Escudo')
       ,('PYG','Guarani')
       ,('ROL','Leu')
       ,('RUB','Russian Ruble')
       ,('RUR','Russian Ruble(old)')
       ,('SAR','Saudi Riyal')
       ,('SEK','Swedish Krona')
       ,('SGD','Singapore Dollar')
       ,('SIT','Tolar')
       ,('SKK','Slovak Koruna')
       ,('SVC','El Salvador Colon')
       ,('THB','Baht')
       ,('TND','Tunisian Dinar')
       ,('TRL','Turkish Lira')
       ,('TTD','Trinidad and Tobago Dollar')
       ,('TWD','New Taiwan Dollar')
       ,('USD','US Dollar')
       ,('UYU','Uruguayan Peso')
       ,('VEB','Bolivar')
       ,('VND','Dong')
       ,('XOF','CFA Franc BCEAO')
       ,('ZAR','Rand')
       ,('ZWD','Zimbabwe Dollar');

MERGE [sales].[currency] AS tgt
USING (SELECT   tc.[currency_code]
               ,tc.[name]
       FROM     #currency AS tc) AS src
ON  src.[currency_code] = tgt.[currency_code]
    AND src.[name] = tgt.[name]
WHEN NOT MATCHED BY TARGET THEN INSERT (
    [currency_code]
   ,[name]
   ,[modified_date]
) VALUES (
    src.[currency_code]
   ,src.[name]
   ,GETUTCDATE()
)
WHEN NOT MATCHED BY SOURCE THEN DELETE;

GO