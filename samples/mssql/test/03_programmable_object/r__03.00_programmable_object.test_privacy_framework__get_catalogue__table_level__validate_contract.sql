-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_programmable_object.test_privacy_framework__get_catalogue__table_level__validate_contract
AS
BEGIN

    EXEC tsqlt.ExpectNoException;

    CREATE TABLE #expected (
        [key]                       NVARCHAR(515) NOT NULL
       ,[Business Justification]    NVARCHAR(50)      NULL
       ,[DRP Typel]                 VARCHAR(20)       NULL
       ,[Transactional]             CHAR(5)           NULL
       ,[DRP Duration]              VARCHAR(50)       NULL
    );

    --Call the proc 
    INSERT INTO #expected (
        [key]
       ,[Business Justification]
       ,[DRP Typel]
       ,[Transactional]
       ,[DRP Duration]
    )
    EXEC privacy_framework.get_catalogue__table_level;

END;
GO