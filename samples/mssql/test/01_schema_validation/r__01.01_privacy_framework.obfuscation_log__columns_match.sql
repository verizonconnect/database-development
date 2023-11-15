-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_schema_validation.test_obfuscation_log__columns_match
AS
BEGIN
 
    CREATE TABLE [privacy_framework].[obfuscation_log_tsqlt](
        [log_id] int NOT NULL
       ,[created_utc_when] datetime2(3) NOT NULL
       ,[message] varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'privacy_framework.obfuscation_log_tsqlt'
                                      ,@Actual = N'privacy_framework.obfuscation_log'
                                      ,@Message = N'Column definitions do not match';
END;
GO
