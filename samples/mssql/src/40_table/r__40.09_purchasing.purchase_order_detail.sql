
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[purchasing].[purchase_order_detail]') AND type in (N'U'))
BEGIN
CREATE TABLE [purchasing].[purchase_order_detail](
    [purchase_order_id] [int] NOT NULL,
    [purchase_order_detail_id] [int] IDENTITY(1,1) NOT NULL,
    [due_date] [datetime] NOT NULL,
    [order_qty] [smallint] NOT NULL,
    [product_id] [int] NOT NULL,
    [unit_price] [money] NOT NULL,
    [line_total]  AS (isnull([order_qty]*[unit_price],(0.00))),
    [received_qty] [decimal](8, 2) NOT NULL,
    [rejected_qty] [decimal](8, 2) NOT NULL,
    [stocked_qty]  AS (isnull([received_qty]-[rejected_qty],(0.00))),
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[purchasing].[purchase_order_detail]') AND name = N'IX_purchase_order_detail_product_id')
CREATE NONCLUSTERED INDEX [IX_purchase_order_detail_product_id] ON [purchasing].[purchase_order_detail]
(
    [product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_detail', N'COLUMN',N'purchase_order_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. Foreign key to purchase_order_header.purchase_order_id.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_detail', @level2type=N'COLUMN',@level2name=N'purchase_order_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_detail', N'COLUMN',N'purchase_order_detail_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. One line number per purchased product.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_detail', @level2type=N'COLUMN',@level2name=N'purchase_order_detail_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_detail', N'COLUMN',N'due_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date the product is expected to be received.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_detail', @level2type=N'COLUMN',@level2name=N'due_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_detail', N'COLUMN',N'order_qty'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'quantity ordered.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_detail', @level2type=N'COLUMN',@level2name=N'order_qty'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_detail', N'COLUMN',N'product_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'product identification number. Foreign key to product.product_id.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_detail', @level2type=N'COLUMN',@level2name=N'product_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_detail', N'COLUMN',N'unit_price'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'vendor''s selling price of a single product.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_detail', @level2type=N'COLUMN',@level2name=N'unit_price'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_detail', N'COLUMN',N'line_total'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Per product subtotal. Computed as order_qty * unit_price.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_detail', @level2type=N'COLUMN',@level2name=N'line_total'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_detail', N'COLUMN',N'received_qty'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'quantity actually received from the vendor.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_detail', @level2type=N'COLUMN',@level2name=N'received_qty'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_detail', N'COLUMN',N'rejected_qty'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'quantity rejected during inspection.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_detail', @level2type=N'COLUMN',@level2name=N'rejected_qty'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_detail', N'COLUMN',N'stocked_qty'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'quantity accepted into inventory. Computed as received_qty - rejected_qty.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_detail', @level2type=N'COLUMN',@level2name=N'stocked_qty'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_detail', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_detail', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_detail', N'INDEX',N'IX_purchase_order_detail_product_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nonclustered index.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_detail', @level2type=N'INDEX',@level2name=N'IX_purchase_order_detail_product_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_detail', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Individual products associated with a specific purchase order. See purchase_order_header.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_detail'
GO