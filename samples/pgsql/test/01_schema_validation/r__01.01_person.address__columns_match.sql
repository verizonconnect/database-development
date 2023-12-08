
CREATE OR ALTER PROCEDURE test_schema_validation.test_address__columns_match
AS
BEGIN
 
    CREATE TABLE [person].[address_tsqlt](
        [address_id] int NOT NULL
       ,[address_line_1] nvarchar(60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[address_line_2] nvarchar(60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
       ,[city] nvarchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[state_province_id] int NOT NULL
       ,[postal_code] nvarchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[spatial_location] geography NULL
       ,[rowguid] uniqueidentifier NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'person.address_tsqlt'
                                      ,@Actual = N'person.address'
                                      ,@Message = N'Column definitions do not match';
END;
GO
