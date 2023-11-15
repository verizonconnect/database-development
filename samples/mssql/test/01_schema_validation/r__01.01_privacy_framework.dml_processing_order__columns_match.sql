-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_schema_validation.test_dml_processing_order__columns_match
AS
BEGIN
 
    CREATE TABLE [privacy_framework].[dml_processing_order_tsqlt](
        sch_nm                           sysname      NOT NULL
       ,tbl_nm                           sysname      NOT NULL
       ,processing_order                 SMALLINT     NOT NULL
       ,created_utc_when                 DATETIME2(3) NOT NULL
       ,modified_utc_when                DATETIME2(3)     NULL
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'privacy_framework.dml_processing_order_tsqlt'
                                      ,@Actual = N'privacy_framework.dml_processing_order'
                                      ,@Message = N'Column definitions do not match';
END;
GO
