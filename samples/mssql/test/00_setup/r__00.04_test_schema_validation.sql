IF SCHEMA_ID('test_schema_validation') IS NULL
    BEGIN
        DECLARE @sql VARCHAR(200) = 'CREATE SCHEMA [test_schema_validation];';
        EXEC (@sql);
        
        DECLARE @ep VARCHAR(1000) = '
        EXECUTE sp_addextendedproperty @name = N''tSQLt.TestClass''
                                      ,@value = 1
                                      ,@level0type = N''SCHEMA''
                                      ,@level0name = N''test_schema_validation''';
        EXEC (@ep);
    END
GO
