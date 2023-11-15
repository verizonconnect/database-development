-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_schema_validation.test_obfuscation_subject_status__columns_match
AS
BEGIN
 
    CREATE TABLE [privacy_framework].[obfuscation_subject_status_tsqlt](
        [account_id] int NOT NULL
       ,[subject_type_id] smallint NOT NULL
       ,[subject_id] int NOT NULL
       ,[status_id] smallint NOT NULL
       ,[created_utc_when] datetime2(3) NOT NULL
       ,[modified_utc_when] datetime2(3) NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'privacy_framework.obfuscation_subject_status_tsqlt'
                                      ,@Actual = N'privacy_framework.obfuscation_subject_status'
                                      ,@Message = N'Column definitions do not match';
END;
GO
