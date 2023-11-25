
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[production].[product_photo]') AND type in (N'U'))
BEGIN
CREATE TABLE [production].[product_photo](
    [product_photo_id] [int] IDENTITY(1,1) NOT NULL,
    [thumbnail_photo] [varbinary](max) NULL,
    [thumbnail_photo_filename] [nvarchar](50) NULL,
    [large_photo] [varbinary](max) NULL,
    [large_photo_filename] [nvarchar](50) NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_photo', N'COLUMN',N'product_photo_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for product_photo records.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_photo', @level2type=N'COLUMN',@level2name=N'product_photo_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_photo', N'COLUMN',N'thumbnail_photo'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Small image of the product.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_photo', @level2type=N'COLUMN',@level2name=N'thumbnail_photo'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_photo', N'COLUMN',N'thumbnail_photo_filename'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Small image file name.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_photo', @level2type=N'COLUMN',@level2name=N'thumbnail_photo_filename'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_photo', N'COLUMN',N'large_photo'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Large image of the product.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_photo', @level2type=N'COLUMN',@level2name=N'large_photo'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_photo', N'COLUMN',N'large_photo_filename'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Large image file name.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_photo', @level2type=N'COLUMN',@level2name=N'large_photo_filename'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_photo', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_photo', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_photo', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'product images.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_photo'
GO
