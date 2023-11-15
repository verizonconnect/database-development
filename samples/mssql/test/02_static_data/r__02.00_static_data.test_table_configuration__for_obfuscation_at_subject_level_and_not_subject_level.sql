-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_static_data.test_table_configuration__for_obfuscation_at_subject_level_and_not_subject_level
AS
BEGIN

    SELECT tc.sch_nm
          ,tc.tbl_nm
    INTO #actual
    FROM privacy_framework.table_configuration tc
    WHERE EXISTS(--Column to obfuscate at subject level
            SELECT 1
            FROM privacy_framework.obfuscation_column_configuration cc
            WHERE tc.sch_nm = cc.sch_nm
            AND tc.tbl_nm = cc.tbl_nm
            AND cc.obfuscated_subject_level_indicator = 1)
    AND EXISTS(--Column to obfuscate soley at account level
            SELECT 1
            FROM privacy_framework.obfuscation_column_configuration cc
            WHERE tc.sch_nm = cc.sch_nm
            AND tc.tbl_nm = cc.tbl_nm
            AND cc.obfuscated_subject_level_indicator = 0)
    AND tc.obfuscated_ind_column_name IS NOT NULL;

    EXEC tsqlt.AssertEmptyTable @TableName = N'#actual'
                               ,@Message = N'Table has both subject level and only account level obfuscation with the obfuscated_ind column set - may result in columns left unobfuscated at account level';
    
END;
GO
