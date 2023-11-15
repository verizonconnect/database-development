-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_schema_validation.test_obfuscation_method__columns_match
AS
BEGIN
 
    CREATE TABLE [privacy_framework].[obfuscation_method_tsqlt](
        [obfuscation_method_id] int NOT NULL
       ,[obfuscation_method_desc] nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'privacy_framework.obfuscation_method_tsqlt'
                                      ,@Actual = N'privacy_framework.obfuscation_method'
                                      ,@Message = N'Column definitions do not match';
END;
GO
