-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_static_data.test_table_configuration__for_obfuscation_or_subject_data
AS
BEGIN

    SELECT tc.sch_nm
          ,tc.tbl_nm
    INTO #actual
    FROM privacy_framework.table_configuration tc
    WHERE NOT EXISTS(
            SELECT 1
            FROM privacy_framework.obfuscation_column_configuration cc
            WHERE tc.sch_nm = cc.sch_nm
            AND tc.tbl_nm = cc.tbl_nm)
    AND NOT EXISTS(
            SELECT 1
            FROM privacy_framework.column_data_dictionary cdd
            WHERE tc.sch_nm = cdd.sch_nm
            AND tc.tbl_nm = cdd.tbl_nm
            AND cdd.subject_data_type_id IS NOT NULL
            AND cdd.subject_type_id IS NOT NULL);

    EXEC tsqlt.AssertEmptyTable @TableName = N'#actual'
                               ,@Message = N'Table in privacy_framework.table_configuration not in privacy_framework.obfuscation_column_configuration or marked as subject data in column_data_dictionary';
    
END;
GO
