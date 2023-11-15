-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_schema_validation.test_obfuscation_status__columns_match
AS
BEGIN
 
    CREATE TABLE [privacy_framework].[obfuscation_status_tsqlt](
        [status_id] smallint NOT NULL
       ,[status_desc] varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'privacy_framework.obfuscation_status_tsqlt'
                                      ,@Actual = N'privacy_framework.obfuscation_status'
                                      ,@Message = N'Column definitions do not match';
END;
GO
