SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[production].[document]') AND type in (N'U'))
BEGIN
CREATE TABLE [production].[document](
    [document_node] [hierarchyid] NOT NULL,
    [document_level]  AS ([document_node].[GetLevel]()),
    [title] [nvarchar](50) NOT NULL,
    [owner] [int] NOT NULL,
    [folder_flag] [bit] NOT NULL,
    [file_name] [nvarchar](400) NOT NULL,
    [file_extension] [nvarchar](8) NOT NULL,
    [revision] [nchar](5) NOT NULL,
    [change_number] [int] NOT NULL,
    [status] [tinyint] NOT NULL,
    [document_summary] [nvarchar](max) NULL,
    [document] [varbinary](max) NULL,
    [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'document', N'COLUMN',N'document_node'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for document records.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'document', @level2type=N'COLUMN',@level2name=N'document_node'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'document', N'COLUMN',N'document_level'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Depth in the document hierarchy.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'document', @level2type=N'COLUMN',@level2name=N'document_level'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'document', N'COLUMN',N'title'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'title of the document.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'document', @level2type=N'COLUMN',@level2name=N'title'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'document', N'COLUMN',N'owner'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'employee who controls the document.  Foreign key to employee.business_entity_id' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'document', @level2type=N'COLUMN',@level2name=N'owner'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'document', N'COLUMN',N'folder_flag'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 = This is a folder, 1 = This is a document.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'document', @level2type=N'COLUMN',@level2name=N'folder_flag'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'document', N'COLUMN',N'file_name'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'File name of the document' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'document', @level2type=N'COLUMN',@level2name=N'file_name'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'document', N'COLUMN',N'file_extension'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'File extension indicating the document type. For example, .doc or .txt.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'document', @level2type=N'COLUMN',@level2name=N'file_extension'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'document', N'COLUMN',N'revision'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'revision number of the document. ' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'document', @level2type=N'COLUMN',@level2name=N'revision'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'document', N'COLUMN',N'change_number'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Engineering change approval number.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'document', @level2type=N'COLUMN',@level2name=N'change_number'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'document', N'COLUMN',N'status'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1 = Pending approval, 2 = Approved, 3 = Obsolete' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'document', @level2type=N'COLUMN',@level2name=N'status'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'document', N'COLUMN',N'document_summary'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'document abstract.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'document', @level2type=N'COLUMN',@level2name=N'document_summary'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'document', N'COLUMN',N'document'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Complete document.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'document', @level2type=N'COLUMN',@level2name=N'document'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'document', N'COLUMN',N'rowguid'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Required for FileStream.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'document', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'document', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'document', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'document', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'product maintenance documents.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'document'
GO
