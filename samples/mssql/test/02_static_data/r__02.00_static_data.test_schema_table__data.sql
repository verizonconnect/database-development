
CREATE OR ALTER PROCEDURE test_static_data.test_schema_table__data
AS
BEGIN
 
    CREATE TABLE #expected (
        id  VARCHAR(20) NOT NULL
       ,PRIMARY KEY (id)
    );

--INSERT INTO #expected(
--    id
--) VALUES
      --E.g.
      -- (1)
      --,(2);

    SELECT  t.id
    INTO    #actual
    FROM    schema.table AS t;
 
    EXEC tSQLt.AssertEqualsTable @Expected = N'#expected'
                                ,@Actual = N'#actual'
                                ,@Message = N'schema.table data not as expected';
END;
GO
