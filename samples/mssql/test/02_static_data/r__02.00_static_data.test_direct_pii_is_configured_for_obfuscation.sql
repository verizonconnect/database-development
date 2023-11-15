-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_static_data.test_direct_pii_is_configured_for_obfuscation
AS
BEGIN
 
    SELECT  cdd.sch_nm
           ,cdd.tbl_nm
           ,cdd.col_nm
    INTO    #actual
    FROM    privacy_framework.column_data_dictionary AS cdd
            LEFT JOIN privacy_framework.obfuscation_column_configuration AS cf ON cf.sch_nm = cdd.sch_nm
                    AND cf.tbl_nm = cdd.tbl_nm
                    AND cf.col_nm = cdd.col_nm
    WHERE   cf.col_nm IS NULL
            AND cdd.direct_pii_indicator = 1;
    
    EXEC tsqlt.AssertEmptyTable @TableName = N'#actual'
                               ,@Message = N'Direct PII columns found without having obfuscation configured' 
    
END;
GO
