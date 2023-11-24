
CREATE OR ALTER PROCEDURE test_schema_validation.test_ship_method__columns_match
AS
BEGIN
 
    CREATE TABLE [purchasing].[ship_method_tsqlt](
        [ship_method_id] int NOT NULL
       ,[name] [common].[name] NOT NULL
       ,[ship_base] money NOT NULL
       ,[ship_rate] money NOT NULL
       ,[rowguid] uniqueidentifier NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'purchasing.ship_method_tsqlt'
                                      ,@Actual = N'purchasing.ship_method'
                                      ,@Message = N'Column definitions do not match';
END;
GO
