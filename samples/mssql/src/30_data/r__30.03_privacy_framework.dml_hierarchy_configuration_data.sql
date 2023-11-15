-- Copyright (c) 2023. Verizon Connect Ireland Limited. All rights reserved. 
CREATE TABLE #dml_hierarchy_configuration (
    parent_sch_nm       sysname      NOT NULL
   ,parent_tbl_nm       sysname      NOT NULL
   ,parent_join_col_nm  sysname      NOT NULL
   ,child_sch_nm        sysname      NOT NULL
   ,child_tbl_nm        sysname      NOT NULL
   ,child_join_col_nm   sysname      NOT NULL
);

--INSERT INTO #dml_hierarchy_configuration(
--    parent_sch_nm
--   ,parent_tbl_nm
--   ,parent_join_col_nm
--   ,child_sch_nm
--   ,child_tbl_nm
--   ,child_join_col_nm   
--) VALUES  
--        ('parent_sch_nm', 'parent_tbl_nm', 'parent_join_col_nm', 'child_sch_nm', 'child_tbl_nm', 'child_join_col_nm');

MERGE privacy_framework.dml_hierarchy_configuration AS tgt
USING (SELECT   tc.parent_sch_nm
               ,tc.parent_tbl_nm
               ,tc.parent_join_col_nm
               ,tc.child_sch_nm
               ,tc.child_tbl_nm
               ,tc.child_join_col_nm 
       FROM     #dml_hierarchy_configuration AS tc) AS src
ON  src.parent_sch_nm = tgt.parent_sch_nm
    AND src.parent_tbl_nm = tgt.parent_tbl_nm
    AND src.parent_join_col_nm = tgt.parent_join_col_nm
    AND src.child_sch_nm = tgt.child_sch_nm
    AND src.child_tbl_nm = tgt.child_tbl_nm
    AND src.child_join_col_nm = tgt.child_join_col_nm
WHEN NOT MATCHED THEN INSERT (
    parent_sch_nm
   ,parent_tbl_nm
   ,parent_join_col_nm
   ,child_sch_nm
   ,child_tbl_nm
   ,child_join_col_nm  
   ,created_utc_when
) VALUES (
    src.parent_sch_nm
   ,src.parent_tbl_nm
   ,src.parent_join_col_nm
   ,src.child_sch_nm
   ,src.child_tbl_nm
   ,src.child_join_col_nm
   ,SYSUTCDATETIME()
) 
WHEN NOT MATCHED BY SOURCE THEN DELETE;

GO
