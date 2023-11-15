-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_static_data.test_pii_has_defined_subject_id_column
AS
BEGIN

	DECLARE @require_indirectPII_to_be_extracted BIT = 1; --Set to zero to override this test

    SELECT cdd.sch_nm
          ,cdd.tbl_nm
          ,cdd.col_nm
    INTO #actual
    FROM privacy_framework.column_data_dictionary cdd
    WHERE cdd.pii_indicator = 1
	AND @require_indirectPII_to_be_extracted = 1
    AND NOT EXISTS (SELECT 1 FROM privacy_framework.table_configuration AS tc 
					WHERE cdd.sch_nm = tc.sch_nm 
					AND cdd.tbl_nm = tc.tbl_nm
					AND tc.subject_id_column_name IS NOT NULL)

    EXEC tsqlt.AssertEmptyTable @TableName = N'#actual'
                               ,@Message = N'Entry in column_data_dictionary with pii_indicator TRUE and no subject_data_type_id or subject_type_id set.';
        
END;
GO
