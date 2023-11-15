-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_programmable_object.test_privacy_framework__get_catalogue__column_level__validate_contract
AS
BEGIN

    EXEC tsqlt.ExpectNoException;

    CREATE TABLE #expected (
        [key]                       NVARCHAR(515) NOT NULL
       ,[column_name]               NVARCHAR(128) NOT NULL
       ,[PK Ordinal]                INT               NULL
       ,[Sensitive Data Indicator]  VARCHAR(10)   NOT NULL
       ,[Subject Type]              VARCHAR(100)      NULL
       ,[Subject Data Type]         VARCHAR(100)      NULL
    );

    --Call the proc 
    INSERT INTO #expected (
        [key]
       ,[column_name]
       ,[PK Ordinal]
       ,[Sensitive Data Indicator]
       ,[Subject Type]
       ,[Subject Data Type]
    )
    EXEC privacy_framework.get_catalogue__column_level;

END;
GO