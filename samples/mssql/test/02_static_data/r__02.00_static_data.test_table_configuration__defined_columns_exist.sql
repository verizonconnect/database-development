-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_static_data.test_table_configuration__defined_columns_exist

AS
BEGIN

    SELECT tc.sch_nm
          ,tc.tbl_nm
    INTO #actual
    from privacy_framework.table_configuration tc
    where
            --account_id
            not exists (select 1 from information_schema.columns isc
                    WHERE  isc.table_schema = tc.sch_nm
                            AND isc.table_name = tc.tbl_nm
                            AND isc.column_name = tc.account_id_column_name)
    OR    --modified_utc_when
            (   tc.modified_utc_when_column_name IS NOT NULL
            AND
            NOT EXISTS(SELECT 1
                    FROM information_schema.columns isc
                    WHERE isc.table_schema = tc.sch_nm
                            AND isc.table_name = tc.tbl_nm
                            AND isc.column_name = tc.modified_utc_when_column_name)
            )
    OR    --modified_utc_when
            (   tc.obfuscated_ind_column_name IS NOT NULL
            AND
            NOT EXISTS(SELECT 1
                    FROM information_schema.columns isc
                    WHERE isc.table_schema = tc.sch_nm
                            AND isc.table_name = tc.tbl_nm
                            AND isc.column_name = tc.obfuscated_ind_column_name)
            )
    OR    --subject_id
            (   tc.subject_id_column_name IS NOT NULL
            AND
            NOT EXISTS(SELECT 1
                    FROM information_schema.columns isc
                    WHERE isc.table_schema = tc.sch_nm
                            AND isc.table_name = tc.tbl_nm
                            AND isc.column_name = tc.subject_id_column_name)
                );  

    EXEC tsqlt.AssertEmptyTable @TableName = N'#actual'
                               ,@Message = N'Table in privacy_framework.table_configuration has incorrect defined column name for accountid, subjectid, obfuscated_ind or modified_utc_when';
    
END;
GO
