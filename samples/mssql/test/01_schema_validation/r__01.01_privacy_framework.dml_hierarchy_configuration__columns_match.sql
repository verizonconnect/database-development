-- Copyright (c) 2023. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_schema_validation.test_dml_hierarchy_configuration__columns_match
AS
BEGIN
 
    CREATE TABLE [privacy_framework].[dml_hierarchy_configuration_tsqlt](
        parent_sch_nm           sysname      NOT NULL
       ,parent_tbl_nm           sysname      NOT NULL
       ,parent_join_col_nm      sysname      NOT NULL
       ,child_sch_nm            sysname      NOT NULL
       ,child_tbl_nm            sysname      NOT NULL
       ,child_join_col_nm       sysname      NOT NULL
       ,created_utc_when        DATETIME2(3) NOT NULL
       ,modified_utc_when       DATETIME2(3)     NULL
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'privacy_framework.dml_hierarchy_configuration_tsqlt'
                                      ,@Actual = N'privacy_framework.dml_hierarchy_configuration'
                                      ,@Message = N'Column definitions do not match';
END;
GO
