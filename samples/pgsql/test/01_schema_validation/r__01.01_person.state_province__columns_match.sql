
CREATE OR ALTER PROCEDURE test_schema_validation.test_state_province__columns_match
AS
BEGIN
 
    CREATE TABLE [person].[state_province_tsqlt](
        [state_province_id] int NOT NULL
       ,[state_province_code] nchar(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[country_region_code] nvarchar(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[is_only_state_province_flag] [common].[flag] NOT NULL
       ,[name] [common].[name] NOT NULL
       ,[territory_id] int NOT NULL
       ,[rowguid] uniqueidentifier NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'person.state_province_tsqlt'
                                      ,@Actual = N'person.state_province'
                                      ,@Message = N'Column definitions do not match';
END;
GO
