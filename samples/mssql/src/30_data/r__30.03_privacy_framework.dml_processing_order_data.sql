-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE TABLE #dml_processing_order (
    sch_nm              sysname      NOT NULL
   ,tbl_nm              sysname      NOT NULL
   ,processing_order    SMALLINT     NOT NULL
   ,PRIMARY KEY (sch_nm, tbl_nm)
);

INSERT INTO #dml_processing_order(
    sch_nm                
   ,tbl_nm                
   ,processing_order  
) VALUES  
    ('*', '*', 100);

MERGE privacy_framework.dml_processing_order AS tgt
USING (SELECT   tc.sch_nm
               ,tc.tbl_nm
               ,tc.processing_order
       FROM     #dml_processing_order AS tc) AS src
ON  src.sch_nm = tgt.sch_nm
    AND src.tbl_nm = tgt.tbl_nm
WHEN NOT MATCHED THEN INSERT (
    sch_nm                
   ,tbl_nm                
   ,processing_order
   ,created_utc_when
) VALUES (
    src.sch_nm                
   ,src.tbl_nm                
   ,src.processing_order 
   ,SYSUTCDATETIME()
) 
WHEN MATCHED AND tgt.processing_order  <> src.processing_order
THEN UPDATE SET  tgt.processing_order  = src.processing_order
                ,tgt.modified_utc_when = SYSUTCDATETIME()
WHEN NOT MATCHED BY SOURCE THEN DELETE;

GO
    