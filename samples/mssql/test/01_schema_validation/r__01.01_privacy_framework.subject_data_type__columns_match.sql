-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_schema_validation.test_subject_data_type__columns_match
AS
BEGIN
 
    CREATE TABLE [privacy_framework].[subject_data_type_tsqlt](
        [subject_data_type_id] smallint NOT NULL
       ,[subject_data_type_desc] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[subject_data_type_translation_key] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[created_utc_when] datetime2(3) NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'privacy_framework.subject_data_type_tsqlt'
                                      ,@Actual = N'privacy_framework.subject_data_type'
                                      ,@Message = N'Column definitions do not match';
END;
GO
