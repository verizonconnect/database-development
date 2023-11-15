-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_static_data.test_obfuscation_status__data
AS
BEGIN
 
    SET NOCOUNT ON;
    
    CREATE TABLE #expected(
        status_id        SMALLINT NOT NULL,
        status_desc      VARCHAR(20)  NOT NULL
    );

    INSERT INTO #expected (
        [status_id]
       ,[status_desc]) 
    VALUES (1, 'In Progress')
          ,(2, 'Complete')
          ,(3, 'Error');
            
    SELECT  t.status_id
           ,t.status_desc                       
    INTO    #actual
    FROM    privacy_framework.obfuscation_status AS t;
 
    EXEC tSQLt.AssertEqualsTable @Expected = N'#expected'
                                ,@Actual = N'#actual'
                                ,@Message = N'obfuscation_status data not as expected';
 
END;
GO

