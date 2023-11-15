-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE TABLE #table_data_dictionary (
    sch_nm                      SYSNAME       NOT NULL
   ,tbl_nm                      SYSNAME       NOT NULL
   ,transactional_indicator     BIT           NOT NULL
   ,partitioned_indicator       BIT           NOT NULL
   ,drp_type_desc               VARCHAR(20)   NOT NULL
   ,business_justification_id   TINYINT       NOT NULL
   ,PRIMARY KEY (sch_nm, tbl_nm)
);

--INSERT INTO #table_data_dictionary(
--    sch_nm
--   ,tbl_nm
--   ,transactional_indicator
--   ,partitioned_indicator
--   ,drp_type_desc
--   ,business_justification_id
--)
--VALUES  ('sch_nm','tbl_nm',0,0,'RDTXX',0)
 

MERGE privacy_framework.table_data_dictionary AS tgt
USING (SELECT   tc.sch_nm
               ,tc.tbl_nm
               ,tc.transactional_indicator
               ,tc.partitioned_indicator
               ,tc.drp_type_desc
               ,tc.business_justification_id
       FROM     #table_data_dictionary AS tc) AS src
ON  src.sch_nm = tgt.sch_nm
    AND src.tbl_nm = tgt.tbl_nm
WHEN NOT MATCHED THEN INSERT (
    sch_nm
   ,tbl_nm
   ,transactional_indicator
   ,partitioned_indicator
   ,drp_type_desc
   ,business_justification_id
) VALUES (
    src.sch_nm
   ,src.tbl_nm
   ,src.transactional_indicator
   ,src.partitioned_indicator
   ,src.drp_type_desc
   ,src.business_justification_id
) 
WHEN MATCHED AND    (tgt.transactional_indicator    <> src.transactional_indicator
                  OR tgt.partitioned_indicator      <> src.partitioned_indicator
                  OR tgt.drp_type_desc              <> src.drp_type_desc
                  OR tgt.business_justification_id  <> src.business_justification_id)
THEN UPDATE SET      tgt.transactional_indicator    = src.transactional_indicator
                    ,tgt.partitioned_indicator      = src.partitioned_indicator
                    ,tgt.drp_type_desc              = src.drp_type_desc
                    ,tgt.business_justification_id  = src.business_justification_id
                    ,tgt.modified_utc_when          = SYSUTCDATETIME()
WHEN NOT MATCHED BY SOURCE THEN DELETE;

GO
