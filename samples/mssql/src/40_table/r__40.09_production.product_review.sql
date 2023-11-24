/****** Object:  Table [production].[product_review]    Script Date: 16/11/2023 08:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[production].[product_review]') AND type in (N'U'))
BEGIN
CREATE TABLE [production].[product_review](
    [product_review_id] [int] IDENTITY(1,1) NOT NULL,
    [product_id] [int] NOT NULL,
    [reviewer_name] [common].[name] NOT NULL,
    [review_date] [datetime] NOT NULL,
    [email_address] [nvarchar](50) NOT NULL,
    [rating] [int] NOT NULL,
    [comments] [nvarchar](3850) NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_product_review_product_id_name]    Script Date: 16/11/2023 08:45:05 ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[production].[product_review]') AND name = N'IX_product_review_product_id_name')
CREATE NONCLUSTERED INDEX [IX_product_review_product_id_name] ON [production].[product_review]
(
    [product_id] ASC,
    [reviewer_name] ASC
)
INCLUDE([comments]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_review', N'COLUMN',N'product_review_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for product_review records.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_review', @level2type=N'COLUMN',@level2name=N'product_review_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_review', N'COLUMN',N'product_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'product identification number. Foreign key to product.product_id.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_review', @level2type=N'COLUMN',@level2name=N'product_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_review', N'COLUMN',N'reviewer_name'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'name of the reviewer.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_review', @level2type=N'COLUMN',@level2name=N'reviewer_name'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_review', N'COLUMN',N'review_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date review was submitted.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_review', @level2type=N'COLUMN',@level2name=N'review_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_review', N'COLUMN',N'email_address'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Reviewer''s e-mail address.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_review', @level2type=N'COLUMN',@level2name=N'email_address'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_review', N'COLUMN',N'rating'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'product rating given by the reviewer. Scale is 1 to 5 with 5 as the highest rating.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_review', @level2type=N'COLUMN',@level2name=N'rating'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_review', N'COLUMN',N'comments'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Reviewer''s comments' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_review', @level2type=N'COLUMN',@level2name=N'comments'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_review', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_review', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_review', N'INDEX',N'IX_product_review_product_id_name'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nonclustered index.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_review', @level2type=N'INDEX',@level2name=N'IX_product_review_product_id_name'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_review', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'customer reviews of products they have purchased.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_review'
GO
