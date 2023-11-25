
CREATE OR ALTER PROCEDURE test_schema_validation.test_vendor__columns_match
AS
BEGIN
 
    CREATE TABLE [purchasing].[vendor_tsqlt](
        [business_entity_id] int NOT NULL
       ,[account_number] [common].[account_number] NOT NULL
       ,[name] [common].[name] NOT NULL
       ,[credit_rating] tinyint NOT NULL
       ,[preferred_vendor_status] [common].[flag] NOT NULL
       ,[active_flag] [common].[flag] NOT NULL
       ,[purchasing_web_service_url] nvarchar(1024) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'purchasing.vendor_tsqlt'
                                      ,@Actual = N'purchasing.vendor'
                                      ,@Message = N'Column definitions do not match';
END;
GO
