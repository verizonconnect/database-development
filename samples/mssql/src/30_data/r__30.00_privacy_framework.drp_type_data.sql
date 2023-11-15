-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE TABLE #drp_type (
    drp_type_desc  VARCHAR(20) NOT NULL
   ,PRIMARY KEY (drp_type_desc)
);

--INSERT INTO #drp_type(
--    drp_type_desc
--) VALUES
      --Sourced from https://wiki.tools.vz-connect.net/display/AR/Data+Retention+Policy
      --E.g.
      -- ('RDT00')
      --,('RDT01')
      --,('RDT02')
      --,('RDT03')
      --,('RDT04')
      --,('RDT05')
      --,('RDT06')
      --,('RDT07')
      --,('RDT08')
      --,('RDT09')
      --,('RDT10')
      --,('RDT11')
      --,('RDT12')
      --,('RDT13')
      --,('RDT14')
      --,('RDT15')
      --,('RDT16')
      --,('RDT17')
      --,('RDT18')
      --,('RDT19')
      --,('RDT20')
      --,('RDT21')
      --,('RDT22')
      --,('RDT23')
      --,('RDT24')
      --,('RDT25')
      --,('RDT26')
      --,('RDT27')
      --,('RDT28')
      --,('RDT29')
      --,('RDT30')
      --,('RDT99');

MERGE privacy_framework.drp_type AS tgt
USING (SELECT   tc.drp_type_desc
       FROM     #drp_type AS tc) AS src
ON  src.drp_type_desc = tgt.drp_type_desc
WHEN NOT MATCHED BY TARGET THEN INSERT (
    drp_type_desc
) VALUES (
    src.drp_type_desc
) 
WHEN NOT MATCHED BY SOURCE THEN DELETE;

GO