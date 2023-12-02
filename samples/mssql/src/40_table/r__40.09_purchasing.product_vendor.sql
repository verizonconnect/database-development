SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[purchasing].[product_vendor]') AND type in (N'U'))
BEGIN
CREATE TABLE [purchasing].[product_vendor](
    [product_id] [int] NOT NULL,
    [business_entity_id] [int] NOT NULL,
    [average_lead_time] [int] NOT NULL,
    [standard_price] [money] NOT NULL,
    [last_receipt_cost] [money] NULL,
    [last_receipt_date] [datetime] NULL,
    [min_order_qty] [int] NOT NULL,
    [max_order_qty] [int] NOT NULL,
    [on_order_qty] [int] NULL,
    [unit_measure_code] [nchar](3) NOT NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'product_vendor', N'COLUMN',N'product_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. Foreign key to product.product_id.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'product_vendor', @level2type=N'COLUMN',@level2name=N'product_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'product_vendor', N'COLUMN',N'business_entity_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. Foreign key to vendor.business_entity_id.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'product_vendor', @level2type=N'COLUMN',@level2name=N'business_entity_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'product_vendor', N'COLUMN',N'average_lead_time'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The average span of time (in days) between placing an order with the vendor and receiving the purchased product.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'product_vendor', @level2type=N'COLUMN',@level2name=N'average_lead_time'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'product_vendor', N'COLUMN',N'standard_price'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The vendor''s usual selling price.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'product_vendor', @level2type=N'COLUMN',@level2name=N'standard_price'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'product_vendor', N'COLUMN',N'last_receipt_cost'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The selling price when last purchased.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'product_vendor', @level2type=N'COLUMN',@level2name=N'last_receipt_cost'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'product_vendor', N'COLUMN',N'last_receipt_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date the product was last received by the vendor.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'product_vendor', @level2type=N'COLUMN',@level2name=N'last_receipt_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'product_vendor', N'COLUMN',N'min_order_qty'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The maximum quantity that should be ordered.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'product_vendor', @level2type=N'COLUMN',@level2name=N'min_order_qty'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'product_vendor', N'COLUMN',N'max_order_qty'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The minimum quantity that should be ordered.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'product_vendor', @level2type=N'COLUMN',@level2name=N'max_order_qty'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'product_vendor', N'COLUMN',N'on_order_qty'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The quantity currently on order.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'product_vendor', @level2type=N'COLUMN',@level2name=N'on_order_qty'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'product_vendor', N'COLUMN',N'unit_measure_code'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The product''s unit of measure.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'product_vendor', @level2type=N'COLUMN',@level2name=N'unit_measure_code'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'product_vendor', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'product_vendor', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'product_vendor', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Cross-reference table mapping vendors with the products they supply.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'product_vendor'
GO
