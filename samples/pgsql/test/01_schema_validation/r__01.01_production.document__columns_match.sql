
CREATE OR ALTER PROCEDURE test_schema_validation.test_document__columns_match
AS
BEGIN
 
    CREATE TABLE [production].[document_tsqlt](
        [document_node] hierarchyid NOT NULL
       ,[document_level] smallint NULL
       ,[title] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[owner] int NOT NULL
       ,[folder_flag] bit NOT NULL
       ,[file_name] nvarchar(400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[file_extension] nvarchar(8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[revision] nchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[change_number] int NOT NULL
       ,[status] tinyint NOT NULL
       ,[document_summary] nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
       ,[document] varbinary(MAX)  NULL
       ,[rowguid] uniqueidentifier NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'production.document_tsqlt'
                                      ,@Actual = N'production.document'
                                      ,@Message = N'Column definitions do not match';
END;
GO
