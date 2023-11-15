-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_programmable_object.test_privacy_framework__add_obfuscation_log
AS
BEGIN

    --create the schemas and tables to be dropped
	declare @message varchar(max) = 'Test message to log';


    --Clear the tables referenced by the function
    --Need to isolate the tests from the data in the static data tables
    EXEC tSQLt.FakeTable @TableName = '[privacy_framework].[obfuscation_log]', @Identity = 1;

    --Run the SP
    EXEC privacy_framework.add_obfuscation_log @message = @message;

    --Expected values
    CREATE TABLE #expected (
        log_id                INT   NOT NULL
        ,message              VARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS);

    INSERT INTO #expected (log_id, message)
    VALUES (1, @message);

    EXEC tSQLt.AssertEqualsTable @Expected = N'#expected'
                                ,@Actual = N'[privacy_framework].[obfuscation_log]'
                                ,@Message = N'Expected values not found in the obfuscation_log';

    SELECT  1 as col
    INTO    #actual
    FROM    privacy_framework.obfuscation_log l
    WHERE   l.created_utc_when < dateadd(minute, -5, GETUTCDATE());
    
    EXEC tsqlt.AssertEmptyTable @TableName = N'#actual'
                               ,@Message = N'Incorrect created_utc_when for message in obfuscation_log'; 

END;
GO
