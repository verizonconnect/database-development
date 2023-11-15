-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_schema_validation.test_table_data_dictionary__columns_match
AS
BEGIN
 
    CREATE TABLE [privacy_framework].[table_data_dictionary_tsqlt](
        [sch_nm] sysname NOT NULL
       ,[tbl_nm] sysname NOT NULL
       ,[transactional_indicator] bit NOT NULL
       ,[partitioned_indicator] bit NOT NULL
       ,[drp_type_desc] varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[business_justification_id] tinyint NOT NULL
       ,[created_utc_when] datetime2(3) NOT NULL
       ,[modified_utc_when] datetime2(3) NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'privacy_framework.table_data_dictionary_tsqlt'
                                      ,@Actual = N'privacy_framework.table_data_dictionary'
                                      ,@Message = N'Column definitions do not match';
END;
GO
