-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE TABLE #table_configuration (
     sch_nm                          SYSNAME       NOT NULL
    ,tbl_nm                          SYSNAME       NOT NULL
    ,batch_size                      INT           NOT NULL
    ,account_id_column_name          NVARCHAR(128) NOT NULL
    ,modified_utc_when_column_name   NVARCHAR(128) NOT NULL
    ,obfuscated_ind_column_name      NVARCHAR(128) NOT NULL
    ,subject_id_column_name          SYSNAME           NULL
   ,PRIMARY KEY (sch_nm, tbl_nm)
);

--INSERT INTO #table_configuration(
--   sch_nm
--  ,tbl_nm
--  ,batch_size
--  ,account_id_column_name
--  ,modified_utc_when_column_name
--  ,obfuscated_ind_column_name
--  ,subject_id_column_name
--) VALUES  
--        ();
 
MERGE privacy_framework.table_configuration AS tgt
USING (SELECT   tc.sch_nm
               ,tc.tbl_nm
               ,tc.batch_size
               ,tc.account_id_column_name
               ,tc.modified_utc_when_column_name
               ,tc.obfuscated_ind_column_name
               ,tc.subject_id_column_name
       FROM     #table_configuration AS tc) AS src
ON  src.sch_nm = tgt.sch_nm
    AND src.tbl_nm = tgt.tbl_nm
WHEN NOT MATCHED THEN INSERT (
    sch_nm
   ,tbl_nm
   ,batch_size
   ,account_id_column_name
   ,modified_utc_when_column_name
   ,obfuscated_ind_column_name
   ,subject_id_column_name
) VALUES (
    src.sch_nm
   ,src.tbl_nm
   ,src.batch_size
   ,src.account_id_column_name
   ,src.modified_utc_when_column_name
   ,src.obfuscated_ind_column_name
   ,src.subject_id_column_name
) 
WHEN MATCHED
THEN UPDATE SET      tgt.batch_size                     = src.batch_size
                    ,tgt.account_id_column_name         = src.account_id_column_name
                    ,tgt.modified_utc_when_column_name  = src.modified_utc_when_column_name
                    ,tgt.obfuscated_ind_column_name     = src.obfuscated_ind_column_name
                    ,tgt.subject_id_column_name         = src.subject_id_column_name
                    ,tgt.modified_utc_when              = SYSUTCDATETIME()
WHEN NOT MATCHED BY SOURCE THEN DELETE;

GO
