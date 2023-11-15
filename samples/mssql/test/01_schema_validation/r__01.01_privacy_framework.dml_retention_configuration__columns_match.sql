-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_schema_validation.test_dml_retention_configuration__columns_match
AS
BEGIN
 
    CREATE TABLE [privacy_framework].[dml_retention_configuration_tsqlt](
        sch_nm                           sysname      NOT NULL
       ,tbl_nm                           sysname      NOT NULL
       ,retention_period_type            CHAR(2)      NOT NULL
       ,retention_period_value           SMALLINT     NOT NULL
       ,days_to_process                  SMALLINT     NOT NULL
       ,created_utc_when                 DATETIME2(3) NOT NULL
       ,modified_utc_when                DATETIME2(3)     NULL
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'privacy_framework.dml_retention_configuration_tsqlt'
                                      ,@Actual = N'privacy_framework.dml_retention_configuration'
                                      ,@Message = N'Column definitions do not match';
END;
GO
