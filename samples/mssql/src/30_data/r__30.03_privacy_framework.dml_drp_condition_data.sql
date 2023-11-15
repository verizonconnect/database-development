-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE TABLE #dml_drp_condition (
    sch_nm          sysname         NOT NULL
   ,tbl_nm          sysname         NOT NULL
   ,drp_condition   NVARCHAR(2000)  NOT NULL
   ,PRIMARY KEY (sch_nm, tbl_nm)
);

--INSERT INTO #dml_drp_condition(
--    sch_nm                
--   ,tbl_nm                
--   ,drp_condition  
--) VALUES  
--    ('sch_nm', 'tbl_nm', N'[tbl_nm].[drp_col]');
    
MERGE privacy_framework.dml_drp_condition AS tgt
USING (SELECT   tc.sch_nm
               ,tc.tbl_nm
               ,tc.drp_condition
       FROM     #dml_drp_condition AS tc) AS src
ON  src.sch_nm = tgt.sch_nm
    AND src.tbl_nm = tgt.tbl_nm
WHEN NOT MATCHED THEN INSERT (
    sch_nm                
   ,tbl_nm                
   ,drp_condition
   ,created_utc_when
) VALUES (
    src.sch_nm                
   ,src.tbl_nm                
   ,src.drp_condition 
   ,SYSUTCDATETIME()
) 
WHEN MATCHED AND tgt.drp_condition    <> src.drp_condition
THEN UPDATE SET  tgt.drp_condition     = src.drp_condition
                ,tgt.modified_utc_when = SYSUTCDATETIME()
WHEN NOT MATCHED BY SOURCE THEN DELETE;

GO
    