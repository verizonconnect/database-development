-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_schema_validation.test_obfuscation_column_configuration__columns_match
AS
BEGIN
 
    CREATE TABLE [privacy_framework].[obfuscation_column_configuration_tsqlt](
        [sch_nm] sysname NOT NULL
       ,[tbl_nm] sysname NOT NULL
       ,[col_nm] sysname NOT NULL
       ,[obfuscation_method_id] int NOT NULL
       ,[obfuscated_subject_level_indicator] bit NOT NULL
       ,[created_utc_when] datetime2(3) NOT NULL
       ,[modified_utc_when] datetime2(3) NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'privacy_framework.obfuscation_column_configuration_tsqlt'
                                      ,@Actual = N'privacy_framework.obfuscation_column_configuration'
                                      ,@Message = N'Column definitions do not match';
END;
GO
