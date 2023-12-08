SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[production].[product_description]') AND type in (N'U'))
BEGIN
CREATE TABLE [production].[product_description](
    [product_description_id] [int] IDENTITY(1,1) NOT NULL,
    [description] [nvarchar](400) NOT NULL,
    [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_description', N'COLUMN',N'product_description_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for product_description records.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_description', @level2type=N'COLUMN',@level2name=N'product_description_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_description', N'COLUMN',N'description'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Description of the product.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_description', @level2type=N'COLUMN',@level2name=N'description'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_description', N'COLUMN',N'rowguid'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_description', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_description', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_description', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_description', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'product descriptions in several languages.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_description'
GO
