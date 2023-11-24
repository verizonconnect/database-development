
CREATE OR ALTER PROCEDURE test_schema_validation.test_location__columns_match
AS
BEGIN
 
    CREATE TABLE [production].[location_tsqlt](
        [location_id] smallint NOT NULL
       ,[name] [common].[name] NOT NULL
       ,[cost_rate] smallmoney NOT NULL
       ,[availability] decimal(8,2) NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'production.location_tsqlt'
                                      ,@Actual = N'production.location'
                                      ,@Message = N'Column definitions do not match';
END;
GO
