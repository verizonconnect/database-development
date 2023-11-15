-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE TABLE #obfuscation_column_configuration (
    sch_nm                                  SYSNAME      NOT NULL
   ,tbl_nm                                  SYSNAME      NOT NULL
   ,col_nm                                  SYSNAME      NOT NULL
   ,obfuscation_method_id                   INT          NOT NULL
   ,obfuscated_subject_level_indicator      BIT          NOT NULL
   ,PRIMARY KEY (sch_nm, tbl_nm, col_nm)
);
GO

--INSERT INTO #obfuscation_column_configuration (
--    sch_nm                        
--   ,tbl_nm                        
--   ,col_nm                        
--   ,obfuscation_method_id         
--   ,obfuscated_subject_level_indicator         
--) VALUES   
--    ();

MERGE privacy_framework.obfuscation_column_configuration AS tgt
USING (SELECT   tc.sch_nm
               ,tc.tbl_nm
               ,tc.col_nm
               ,tc.obfuscation_method_id
               ,tc.obfuscated_subject_level_indicator
       FROM     #obfuscation_column_configuration AS tc) AS src
ON  src.sch_nm = tgt.sch_nm
    AND src.tbl_nm = tgt.tbl_nm
    AND src.col_nm = tgt.col_nm
WHEN NOT MATCHED THEN INSERT (
    sch_nm                        
   ,tbl_nm                        
   ,col_nm                        
   ,obfuscation_method_id   
   ,obfuscated_subject_level_indicator      
) VALUES (
    src.sch_nm                        
   ,src.tbl_nm                        
   ,src.col_nm                        
   ,src.obfuscation_method_id    
   ,src.obfuscated_subject_level_indicator      
) 
WHEN MATCHED AND    (tgt.obfuscation_method_id              <> src.obfuscation_method_id
                  OR tgt.obfuscated_subject_level_indicator <> src.obfuscated_subject_level_indicator)
THEN UPDATE SET      tgt.obfuscation_method_id               = src.obfuscation_method_id
                    ,tgt.obfuscated_subject_level_indicator  = src.obfuscated_subject_level_indicator
                    ,tgt.modified_utc_when              = SYSUTCDATETIME()
WHEN NOT MATCHED BY SOURCE THEN DELETE;

GO
