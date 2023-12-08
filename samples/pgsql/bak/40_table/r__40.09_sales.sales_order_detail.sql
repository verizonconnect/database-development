SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[sales].[sales_order_detail]') AND type in (N'U'))
BEGIN
CREATE TABLE [sales].[sales_order_detail](
    [sales_order_id] [int] NOT NULL,
    [sales_order_detail_id] [int] IDENTITY(1,1) NOT NULL,
    [carrier_tracking_number] [nvarchar](25) NULL,
    [order_qty] [smallint] NOT NULL,
    [product_id] [int] NOT NULL,
    [special_offer_id] [int] NOT NULL,
    [unit_price] [money] NOT NULL,
    [unit_price_discount] [money] NOT NULL,
    [line_total]  AS (isnull(([unit_price]*((1.0)-[unit_price_discount]))*[order_qty],(0.0))),
    [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_detail', N'COLUMN',N'sales_order_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. Foreign key to sales_order_header.sales_order_id.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_detail', @level2type=N'COLUMN',@level2name=N'sales_order_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_detail', N'COLUMN',N'sales_order_detail_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. One incremental unique number per product sold.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_detail', @level2type=N'COLUMN',@level2name=N'sales_order_detail_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_detail', N'COLUMN',N'carrier_tracking_number'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Shipment tracking number supplied by the shipper.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_detail', @level2type=N'COLUMN',@level2name=N'carrier_tracking_number'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_detail', N'COLUMN',N'order_qty'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'quantity ordered per product.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_detail', @level2type=N'COLUMN',@level2name=N'order_qty'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_detail', N'COLUMN',N'product_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'product sold to customer. Foreign key to product.product_id.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_detail', @level2type=N'COLUMN',@level2name=N'product_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_detail', N'COLUMN',N'special_offer_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Promotional code. Foreign key to special_offer.special_offer_id.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_detail', @level2type=N'COLUMN',@level2name=N'special_offer_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_detail', N'COLUMN',N'unit_price'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Selling price of a single product.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_detail', @level2type=N'COLUMN',@level2name=N'unit_price'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_detail', N'COLUMN',N'unit_price_discount'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Discount amount.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_detail', @level2type=N'COLUMN',@level2name=N'unit_price_discount'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_detail', N'COLUMN',N'line_total'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Per product subtotal. Computed as unit_price * (1 - unit_price_discount) * order_qty.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_detail', @level2type=N'COLUMN',@level2name=N'line_total'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_detail', N'COLUMN',N'rowguid'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_detail', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_detail', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_detail', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_detail', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Individual products associated with a specific sales order. See sales_order_header.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_detail'
GO