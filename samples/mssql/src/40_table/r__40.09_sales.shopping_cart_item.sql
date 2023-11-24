/****** Object:  Table [sales].[shopping_cart_item]    Script Date: 16/11/2023 08:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[sales].[shopping_cart_item]') AND type in (N'U'))
BEGIN
CREATE TABLE [sales].[shopping_cart_item](
    [shopping_cart_item_id] [int] IDENTITY(1,1) NOT NULL,
    [shopping_cart_id] [nvarchar](50) NOT NULL,
    [quantity] [int] NOT NULL,
    [product_id] [int] NOT NULL,
    [created_date] [datetime] NOT NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_shopping_cart_item_shopping_cart_id_product_id]    Script Date: 16/11/2023 08:45:05 ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[sales].[shopping_cart_item]') AND name = N'IX_shopping_cart_item_shopping_cart_id_product_id')
CREATE NONCLUSTERED INDEX [IX_shopping_cart_item_shopping_cart_id_product_id] ON [sales].[shopping_cart_item]
(
    [shopping_cart_id] ASC,
    [product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'shopping_cart_item', N'COLUMN',N'shopping_cart_item_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for shopping_cart_item records.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'shopping_cart_item', @level2type=N'COLUMN',@level2name=N'shopping_cart_item_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'shopping_cart_item', N'COLUMN',N'shopping_cart_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'shopping cart identification number.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'shopping_cart_item', @level2type=N'COLUMN',@level2name=N'shopping_cart_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'shopping_cart_item', N'COLUMN',N'quantity'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'product quantity ordered.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'shopping_cart_item', @level2type=N'COLUMN',@level2name=N'quantity'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'shopping_cart_item', N'COLUMN',N'product_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'product ordered. Foreign key to product.product_id.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'shopping_cart_item', @level2type=N'COLUMN',@level2name=N'product_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'shopping_cart_item', N'COLUMN',N'created_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date the time the record was created.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'shopping_cart_item', @level2type=N'COLUMN',@level2name=N'created_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'shopping_cart_item', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'shopping_cart_item', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'shopping_cart_item', N'INDEX',N'IX_shopping_cart_item_shopping_cart_id_product_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nonclustered index.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'shopping_cart_item', @level2type=N'INDEX',@level2name=N'IX_shopping_cart_item_shopping_cart_id_product_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'shopping_cart_item', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Contains online customer orders until the order is submitted or cancelled.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'shopping_cart_item'
GO
