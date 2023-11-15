-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE TABLE #column_data_dictionary (
    sch_nm                         SYSNAME      NOT NULL
   ,tbl_nm                         SYSNAME      NOT NULL
   ,col_nm                         SYSNAME      NOT NULL
   ,pii_indicator                  BIT          NOT NULL
   ,direct_pii_indicator           BIT              NULL
   ,subject_data_type_id           SMALLINT         NULL 
   ,subject_type_id                SMALLINT         NULL
   ,PRIMARY KEY (sch_nm, tbl_nm, col_nm)
);
GO

--INSERT INTO #column_data_dictionary(
--    sch_nm
--   ,tbl_nm
--   ,col_nm
--   ,pii_indicator
--   ,direct_pii_indicator
--   ,subject_data_type_id
--   ,subject_type_id
--) VALUES 
--        ();

MERGE privacy_framework.column_data_dictionary AS tgt
USING (SELECT   tc.sch_nm
               ,tc.tbl_nm
               ,tc.col_nm
               ,tc.pii_indicator
               ,tc.direct_pii_indicator
               ,tc.subject_data_type_id
               ,tc.subject_type_id
       FROM     #column_data_dictionary AS tc) AS src
ON  src.sch_nm = tgt.sch_nm
    AND src.tbl_nm = tgt.tbl_nm
    AND src.col_nm = tgt.col_nm
WHEN NOT MATCHED THEN INSERT (
    sch_nm                        
   ,tbl_nm                        
   ,col_nm                                    
   ,pii_indicator                 
   ,direct_pii_indicator
   ,subject_data_type_id
   ,subject_type_id
) VALUES (
    src.sch_nm                        
   ,src.tbl_nm                        
   ,src.col_nm                                     
   ,src.pii_indicator                 
   ,src.direct_pii_indicator
   ,src.subject_data_type_id
   ,src.subject_type_id 
) 
WHEN MATCHED
THEN UPDATE SET      tgt.pii_indicator                  = src.pii_indicator
                    ,tgt.direct_pii_indicator           = src.direct_pii_indicator
                    ,tgt.subject_data_type_id           = src.subject_data_type_id
                    ,tgt.subject_type_id                = src.subject_type_id
                    ,tgt.modified_utc_when              = SYSUTCDATETIME()
WHEN NOT MATCHED BY SOURCE THEN DELETE;

GO
