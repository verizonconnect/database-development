-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_static_data.test_pii_is_configured_as_subject_type
AS
BEGIN

    SELECT cdd.sch_nm
          ,cdd.tbl_nm
          ,cdd.col_nm
    INTO #actual
    FROM privacy_framework.column_data_dictionary cdd
    WHERE cdd.pii_indicator = 1
    AND   (cdd.subject_data_type_id IS NULL OR cdd.subject_type_id IS NULL)

    EXEC tsqlt.AssertEmptyTable @TableName = N'#actual'
                               ,@Message = N'Entry in column_data_dictionary with pii_indicator TRUE and no subject_data_type_id or subject_type_id set.';
        
END;
GO
