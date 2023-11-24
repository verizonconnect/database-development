
CREATE OR ALTER PROCEDURE test_schema_validation.test_country_region__columns_match
AS
BEGIN
 
    CREATE TABLE [person].[country_region_tsqlt](
        [country_region_code] nvarchar(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[name] [common].[name] NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'person.country_region_tsqlt'
                                      ,@Actual = N'person.country_region'
                                      ,@Message = N'Column definitions do not match';
END;
GO
