IF SCHEMA_ID('test_programmable_object') IS NULL
    BEGIN
        DECLARE @sql VARCHAR(200) = 'CREATE SCHEMA [test_programmable_object];';
        EXEC (@sql);
        
        DECLARE @ep VARCHAR(1000) = '
        EXECUTE sp_addextendedproperty @name = N''tSQLt.TestClass''
                                      ,@value = 1
                                      ,@level0type = N''SCHEMA''
                                      ,@level0name = N''test_programmable_object''';
        EXEC (@ep);
    END
GO
