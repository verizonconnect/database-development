
CREATE OR ALTER PROCEDURE test_schema_validation.test_unit_measure__columns_match
AS
BEGIN
 
    CREATE TABLE [production].[unit_measure_tsqlt](
        [unit_measure_code] nchar(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[name] [common].[name] NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'production.unit_measure_tsqlt'
                                      ,@Actual = N'production.unit_measure'
                                      ,@Message = N'Column definitions do not match';
END;
GO
