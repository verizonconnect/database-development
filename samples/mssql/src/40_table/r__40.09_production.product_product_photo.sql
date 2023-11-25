
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[production].[product_product_photo]') AND type in (N'U'))
BEGIN
CREATE TABLE [production].[product_product_photo](
    [product_id] [int] NOT NULL,
    [product_photo_id] [int] NOT NULL,
    [primary] [common].[flag] NOT NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_product_photo', N'COLUMN',N'product_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'product identification number. Foreign key to product.product_id.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_product_photo', @level2type=N'COLUMN',@level2name=N'product_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_product_photo', N'COLUMN',N'product_photo_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'product photo identification number. Foreign key to product_photo.product_photo_id.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_product_photo', @level2type=N'COLUMN',@level2name=N'product_photo_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_product_photo', N'COLUMN',N'Primary'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 = Photo is not the principal image. 1 = Photo is the principal image.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_product_photo', @level2type=N'COLUMN',@level2name=N'Primary'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_product_photo', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_product_photo', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_product_photo', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Cross-reference table mapping products and product photos.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_product_photo'
GO
