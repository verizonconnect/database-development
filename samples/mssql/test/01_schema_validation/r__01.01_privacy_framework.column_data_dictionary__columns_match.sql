-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_schema_validation.test_column_data_dictionary__columns_match
AS
BEGIN
 
    CREATE TABLE [privacy_framework].[column_data_dictionary_tsqlt](
        [sch_nm] sysname NOT NULL
       ,[tbl_nm] sysname NOT NULL
       ,[col_nm] sysname NOT NULL
       ,[pii_indicator] bit NOT NULL
       ,[direct_pii_indicator] bit NOT NULL
       ,[created_utc_when] datetime2(3) NOT NULL
       ,[modified_utc_when] datetime2(3) NULL 
       ,[subject_data_type_id] smallint NULL
       ,[subject_type_id] smallint NULL
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'privacy_framework.column_data_dictionary_tsqlt'
                                      ,@Actual = N'privacy_framework.column_data_dictionary'
                                      ,@Message = N'Column definitions do not match';
END;
GO
