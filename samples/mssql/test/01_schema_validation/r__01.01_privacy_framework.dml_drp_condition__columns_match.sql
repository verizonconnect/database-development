-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_schema_validation.test_dml_drp_condition__columns_match
AS
BEGIN
 
    CREATE TABLE [privacy_framework].[dml_drp_condition_tsqlt](
        sch_nm              sysname         NOT NULL
       ,tbl_nm              sysname         NOT NULL
       ,drp_condition       NVARCHAR(2000)  NOT NULL
       ,created_utc_when    DATETIME2(3)    NOT NULL
       ,modified_utc_when   DATETIME2(3)        NULL
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'privacy_framework.dml_drp_condition_tsqlt'
                                      ,@Actual = N'privacy_framework.dml_drp_condition'
                                      ,@Message = N'Column definitions do not match';
END;
GO
