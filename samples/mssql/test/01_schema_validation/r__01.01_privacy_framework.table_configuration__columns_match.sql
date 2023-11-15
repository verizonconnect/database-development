-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_schema_validation.test_table_configuration__columns_match
AS
BEGIN
 
    CREATE TABLE [privacy_framework].[table_configuration_tsqlt](
        [sch_nm] sysname NOT NULL
       ,[tbl_nm] sysname NOT NULL
       ,[batch_size] int NOT NULL
       ,[account_id_column_name] nvarchar(128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[modified_utc_when_column_name] nvarchar(128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[obfuscated_ind_column_name] nvarchar(128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL     
       ,[created_utc_when] datetime2(3) NOT NULL
       ,[modified_utc_when] datetime2(3) NULL 
       ,[subject_id_column_name] sysname NULL
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'privacy_framework.table_configuration_tsqlt'
                                      ,@Actual = N'privacy_framework.table_configuration'
                                      ,@Message = N'Column definitions do not match';
END;
GO
