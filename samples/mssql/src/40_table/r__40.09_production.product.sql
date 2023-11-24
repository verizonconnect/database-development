/****** Object:  Table [production].[product]    Script Date: 16/11/2023 08:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[production].[product]') AND type in (N'U'))
BEGIN
CREATE TABLE [production].[product](
    [product_id] [int] IDENTITY(1,1) NOT NULL,
    [name] [common].[name] NOT NULL,
    [product_number] [nvarchar](25) NOT NULL,
    [make_flag] [common].[flag] NOT NULL,
    [finished_goods_flag] [common].[flag] NOT NULL,
    [colour] [nvarchar](15) NULL,
    [safety_stock_level] [smallint] NOT NULL,
    [reorder_point] [smallint] NOT NULL,
    [standard_cost] [money] NOT NULL,
    [list_price] [money] NOT NULL,
    [size] [nvarchar](5) NULL,
    [size_unit_measure_code] [nchar](3) NULL,
    [weight_unit_measure_code] [nchar](3) NULL,
    [weight] [decimal](8, 2) NULL,
    [days_to_manufacture] [int] NOT NULL,
    [product_line] [nchar](2) NULL,
    [class] [nchar](2) NULL,
    [style] [nchar](2) NULL,
    [product_sub_category_id] [int] NULL,
    [product_model_id] [int] NULL,
    [sell_start_date] [datetime] NOT NULL,
    [sell_end_date] [datetime] NULL,
    [discontinued_date] [datetime] NULL,
    [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [AK_product_name]    Script Date: 16/11/2023 08:45:05 ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[production].[product]') AND name = N'AK_product_name')
CREATE UNIQUE NONCLUSTERED INDEX [AK_product_name] ON [production].[product]
(
    [name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [AK_product_product_number]    Script Date: 16/11/2023 08:45:05 ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[production].[product]') AND name = N'AK_product_product_number')
CREATE UNIQUE NONCLUSTERED INDEX [AK_product_product_number] ON [production].[product]
(
    [product_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [AK_product_rowguid]    Script Date: 16/11/2023 08:45:05 ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[production].[product]') AND name = N'AK_product_rowguid')
CREATE UNIQUE NONCLUSTERED INDEX [AK_product_rowguid] ON [production].[product]
(
    [rowguid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product', N'COLUMN',N'product_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for product records.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product', @level2type=N'COLUMN',@level2name=N'product_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product', N'COLUMN',N'name'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'name of the product.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product', @level2type=N'COLUMN',@level2name=N'name'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product', N'COLUMN',N'product_number'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique product identification number.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product', @level2type=N'COLUMN',@level2name=N'product_number'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product', N'COLUMN',N'make_flag'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 = product is purchased, 1 = product is manufactured in-house.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product', @level2type=N'COLUMN',@level2name=N'make_flag'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product', N'COLUMN',N'finished_goods_flag'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 = product is not a salable item. 1 = product is salable.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product', @level2type=N'COLUMN',@level2name=N'finished_goods_flag'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product', N'COLUMN',N'colour'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'product color.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product', @level2type=N'COLUMN',@level2name=N'colour'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product', N'COLUMN',N'reorder_point'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Inventory level that triggers a purchase order or work order. ' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product', @level2type=N'COLUMN',@level2name=N'reorder_point'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product', N'COLUMN',N'standard_cost'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Standard cost of the product.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product', @level2type=N'COLUMN',@level2name=N'standard_cost'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product', N'COLUMN',N'list_price'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Selling price.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product', @level2type=N'COLUMN',@level2name=N'list_price'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product', N'COLUMN',N'Size'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'product size.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product', @level2type=N'COLUMN',@level2name=N'Size'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product', N'COLUMN',N'size_unit_measure_code'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unit of measure for Size column.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product', @level2type=N'COLUMN',@level2name=N'size_unit_measure_code'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product', N'COLUMN',N'weight_unit_measure_code'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unit of measure for weight column.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product', @level2type=N'COLUMN',@level2name=N'weight_unit_measure_code'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product', N'COLUMN',N'weight'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'product weight.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product', @level2type=N'COLUMN',@level2name=N'weight'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product', N'COLUMN',N'days_to_manufacture'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of days required to manufacture the product.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product', @level2type=N'COLUMN',@level2name=N'days_to_manufacture'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product', N'COLUMN',N'product_line'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'R = Road, M = Mountain, T = Touring, S = Standard' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product', @level2type=N'COLUMN',@level2name=N'product_line'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product', N'COLUMN',N'class'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'H = High, M = Medium, L = Low' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product', @level2type=N'COLUMN',@level2name=N'class'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product', N'COLUMN',N'style'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'W = Womens, M = Mens, U = Universal' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product', @level2type=N'COLUMN',@level2name=N'style'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product', N'COLUMN',N'product_sub_category_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'product is a member of this product subcategory. Foreign key to productSubcategory.productSubcategory_id. ' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product', @level2type=N'COLUMN',@level2name=N'product_sub_category_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product', N'COLUMN',N'product_model_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'product is a member of this product model. Foreign key to product_model.product_model_id.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product', @level2type=N'COLUMN',@level2name=N'product_model_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product', N'COLUMN',N'sell_start_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date the product was available for sale.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product', @level2type=N'COLUMN',@level2name=N'sell_start_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product', N'COLUMN',N'sell_end_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date the product was no longer available for sale.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product', @level2type=N'COLUMN',@level2name=N'sell_end_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product', N'COLUMN',N'discontinued_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date the product was discontinued.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product', @level2type=N'COLUMN',@level2name=N'discontinued_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product', N'COLUMN',N'rowguid'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product', N'INDEX',N'AK_product_name'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique nonclustered index.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product', @level2type=N'INDEX',@level2name=N'AK_product_name'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product', N'INDEX',N'AK_product_product_number'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique nonclustered index.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product', @level2type=N'INDEX',@level2name=N'AK_product_product_number'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product', N'INDEX',N'AK_product_rowguid'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique nonclustered index. Used to support replication samples.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product', @level2type=N'INDEX',@level2name=N'AK_product_rowguid'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'products sold or used in the manfacturing of sold products.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product'
GO
