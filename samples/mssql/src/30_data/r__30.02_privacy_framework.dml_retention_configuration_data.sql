-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE TABLE #dml_retention_configuration (
    sch_nm                  sysname      NOT NULL
   ,tbl_nm                  sysname      NOT NULL
   ,retention_period_type   CHAR(2)      NOT NULL
   ,retention_period_value  SMALLINT     NOT NULL
   ,days_to_process         SMALLINT     NOT NULL
   ,PRIMARY KEY (sch_nm, tbl_nm)
);

--INSERT INTO #dml_retention_configuration(
--    sch_nm                
--   ,tbl_nm                
--   ,retention_period_type 
--   ,retention_period_value
--   ,days_to_process  
--) VALUES  
--        ('sch_nm', 'tbl_nm', 'MM', 13, 15);

MERGE privacy_framework.dml_retention_configuration AS tgt
USING (SELECT   tc.sch_nm
               ,tc.tbl_nm
               ,tc.retention_period_type
               ,tc.retention_period_value
               ,tc.days_to_process
       FROM     #dml_retention_configuration AS tc) AS src
ON  src.sch_nm = tgt.sch_nm
    AND src.tbl_nm = tgt.tbl_nm
WHEN NOT MATCHED THEN INSERT (
    sch_nm                
   ,tbl_nm                
   ,retention_period_type 
   ,retention_period_value
   ,days_to_process   
   ,created_utc_when
) VALUES (
    src.sch_nm                
   ,src.tbl_nm                
   ,src.retention_period_type 
   ,src.retention_period_value
   ,src.days_to_process 
   ,SYSUTCDATETIME()
) 
WHEN MATCHED AND    (tgt.retention_period_type  <> src.retention_period_type
                  OR tgt.retention_period_value <> src.retention_period_value
                  OR tgt.days_to_process        <> src.days_to_process)
THEN UPDATE SET      tgt.retention_period_type  = src.retention_period_type
                    ,tgt.retention_period_value = src.retention_period_value
                    ,tgt.days_to_process        = src.days_to_process
                    ,tgt.modified_utc_when      = SYSUTCDATETIME()
WHEN NOT MATCHED BY SOURCE THEN DELETE;

GO
    