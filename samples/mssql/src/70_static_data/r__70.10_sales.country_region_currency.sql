CREATE TABLE #country_region_currency (
    [country_region_code] [NVARCHAR](3) NOT NULL
   ,[currency_code]       [NCHAR](3)    NOT NULL
   ,PRIMARY KEY ([country_region_code],[currency_code])
);

INSERT INTO #country_region_currency (
    [country_region_code]
   ,[currency_code]
)
VALUES  ('AE','AED')
       ,('AR','ARS')
       ,('AT','ATS')
       ,('AT','EUR')
       ,('AU','AUD')
       ,('BB','BBD')
       ,('BD','BDT')
       ,('BE','BEF')
       ,('BE','EUR')
       ,('BG','BGN')
       ,('BH','BHD')
       ,('BN','BND')
       ,('BO','BOB')
       ,('BR','BRL')
       ,('BS','BSD')
       ,('BT','BTN')
       ,('CA','CAD')
       ,('CH','CHF')
       ,('CL','CLP')
       ,('CN','CNY')
       ,('CO','COP')
       ,('CR','CRC')
       ,('CY','CYP')
       ,('CZ','CZK')
       ,('DE','DEM')
       ,('DE','EUR')
       ,('DK','DKK')
       ,('DO','DOP')
       ,('DZ','DZD')
       ,('EC','USD')
       ,('EE','EEK')
       ,('EG','EGP')
       ,('ES','ESP')
       ,('ES','EUR')
       ,('FI','EUR')
       ,('FI','FIM')
       ,('FJ','FJD')
       ,('FR','EUR')
       ,('FR','FRF')
       ,('GB','GBP')
       ,('GH','GHC')
       ,('GR','EUR')
       ,('GR','GRD')
       ,('GT','GTQ')
       ,('HK','HKD')
       ,('HR','HRK')
       ,('HU','HUF')
       ,('ID','IDR')
       ,('IE','EUR')
       ,('IE','IEP')
       ,('IL','ILS')
       ,('IN','INR')
       ,('IS','ISK')
       ,('IT','EUR')
       ,('IT','ITL')
       ,('JM','JMD')
       ,('JO','JOD')
       ,('JP','JPY')
       ,('KE','KES')
       ,('KR','KRW')
       ,('KW','KWD')
       ,('LB','LBP')
       ,('LK','LKR')
       ,('LT','LTL')
       ,('LU','EUR')
       ,('LV','LVL')
       ,('MA','MAD')
       ,('MT','MTL')
       ,('MU','MUR')
       ,('MV','MVR')
       ,('MX','MXN')
       ,('MY','MYR')
       ,('NA','NAD')
       ,('NG','NGN')
       ,('NL','EUR')
       ,('NL','NLG')
       ,('NO','NOK')
       ,('NP','NPR')
       ,('NZ','NZD')
       ,('OM','OMR')
       ,('PA','PAB')
       ,('PE','PEN')
       ,('PH','PHP')
       ,('PK','PKR')
       ,('PL','PLN')
       ,('PL','PLZ')
       ,('PT','EUR')
       ,('PT','PTE')
       ,('PY','PYG')
       ,('RO','ROL')
       ,('RU','RUB')
       ,('RU','RUR')
       ,('SA','SAR')
       ,('SE','SEK')
       ,('SG','SGD')
       ,('SI','SIT')
       ,('SK','SKK')
       ,('SV','SVC')
       ,('TH','THB')
       ,('TN','TND')
       ,('TR','TRL')
       ,('TT','TTD')
       ,('TW','TWD')
       ,('US','USD')
       ,('UY','UYU')
       ,('VE','VEB')
       ,('VN','VND')
       ,('ZA','ZAR')
       ,('ZW','ZWD');

MERGE [sales].[country_region_currency] AS tgt
USING (SELECT   tc.[country_region_code]
               ,tc.[currency_code]
       FROM     #country_region_currency AS tc) AS src
ON  src.[country_region_code] = tgt.[country_region_code]
    AND src.[currency_code] = tgt.[currency_code]
WHEN NOT MATCHED BY TARGET THEN INSERT (
    [country_region_code]
   ,[currency_code]
   ,[modified_date]
) VALUES (
    src.[country_region_code]
   ,src.[currency_code]
   ,GETUTCDATE()
)
WHEN NOT MATCHED BY SOURCE THEN DELETE;

GO