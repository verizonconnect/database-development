-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_static_data.test_drp_type_data
AS
BEGIN
 
    CREATE TABLE #expected (
        drp_type_desc  VARCHAR(20) NOT NULL
       ,PRIMARY KEY (drp_type_desc)
    );

--INSERT INTO #expected(
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

    SELECT  t.drp_type_desc
    INTO    #actual
    FROM    privacy_framework.drp_type AS t;
 
    EXEC tSQLt.AssertEqualsTable @Expected = N'#expected'
                                ,@Actual = N'#actual'
                                ,@Message = N'privacy_framework.drp_type data not as expected';
END;
GO
