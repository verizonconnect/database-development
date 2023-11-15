-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_schema_validation.test_business_justification__columns_match
AS
BEGIN
 
    CREATE TABLE [privacy_framework].[business_justification_tsqlt](
        [business_justification_id] tinyint NOT NULL
       ,[business_justification_desc] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[created_utc_when] datetime2(3) NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'privacy_framework.business_justification_tsqlt'
                                      ,@Actual = N'privacy_framework.business_justification'
                                      ,@Message = N'Column definitions do not match';
END;
GO
