BEGIN TRY
    DELETE FROM tsqlt.TestResult;
    -- EXEC tSQLt.RunAll;
END TRY
BEGIN CATCH
    PRINT 'Bury exception to allow all tests to run'
END CATCH
GO

DECLARE @test_count INT = (SELECT COUNT(*) FROM tSQLt.TestResult);

SELECT  tr.Result
       ,tr.Class
       ,tr.TestCase
FROM    tSQLt.TestResult AS tr
WHERE   1 = 1
        AND tr.Result = 'Success';
        
IF EXISTS (SELECT 1
           FROM   tSQLt.TestResult AS tr
           WHERE  1 = 1
                  AND tr.Result IN ('Failure', 'Error'))
    BEGIN
        SELECT  tr.Result
               ,tr.Class
               ,tr.TestCase
        FROM    tSQLt.TestResult AS tr
        WHERE   1 = 1
                AND tr.Result IN ('Failure', 'Error');
            
        SELECT 'Test cases recorded Failures/Errors' AS [Build_Failed];
    END
ELSE IF @test_count = 0
    BEGIN
        SELECT 'Zero tests were recorded' AS [Build_Failed];
    END;
ELSE
    BEGIN

        SELECT 'true'      AS [All Tests Passed]
              ,@test_count AS [Number of Tests Run]
    
    END
GO