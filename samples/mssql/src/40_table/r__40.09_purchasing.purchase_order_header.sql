
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[purchasing].[purchase_order_header]') AND type in (N'U'))
BEGIN
CREATE TABLE [purchasing].[purchase_order_header](
    [purchase_order_id] [int] IDENTITY(1,1) NOT NULL,
    [revision_number] [tinyint] NOT NULL,
    [status] [tinyint] NOT NULL,
    [employee_id] [int] NOT NULL,
    [vendor_id] [int] NOT NULL,
    [ship_method_id] [int] NOT NULL,
    [order_date] [datetime] NOT NULL,
    [ship_date] [datetime] NULL,
    [sub_total] [money] NOT NULL,
    [tax_amt] [money] NOT NULL,
    [freight] [money] NOT NULL,
    [total_due]  AS (isnull(([sub_total]+[tax_amt])+[freight],(0))) PERSISTED NOT NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[purchasing].[purchase_order_header]') AND name = N'IX_purchase_order_header_employee_id')
CREATE NONCLUSTERED INDEX [IX_purchase_order_header_employee_id] ON [purchasing].[purchase_order_header]
(
    [employee_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[purchasing].[purchase_order_header]') AND name = N'IX_purchase_order_header_vendor_id')
CREATE NONCLUSTERED INDEX [IX_purchase_order_header_vendor_id] ON [purchasing].[purchase_order_header]
(
    [vendor_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_header', N'COLUMN',N'purchase_order_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_header', @level2type=N'COLUMN',@level2name=N'purchase_order_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_header', N'COLUMN',N'revision_number'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Incremental number to track changes to the purchase order over time.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_header', @level2type=N'COLUMN',@level2name=N'revision_number'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_header', N'COLUMN',N'status'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Order current status. 1 = Pending; 2 = Approved; 3 = rejected; 4 = Complete' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_header', @level2type=N'COLUMN',@level2name=N'status'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_header', N'COLUMN',N'employee_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'employee who created the purchase order. Foreign key to employee.business_entity_id.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_header', @level2type=N'COLUMN',@level2name=N'employee_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_header', N'COLUMN',N'vendor_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'vendor with whom the purchase order is placed. Foreign key to vendor.business_entity_id.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_header', @level2type=N'COLUMN',@level2name=N'vendor_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_header', N'COLUMN',N'ship_method_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Shipping method. Foreign key to ship_method.ship_method_id.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_header', @level2type=N'COLUMN',@level2name=N'ship_method_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_header', N'COLUMN',N'order_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'purchase order creation date.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_header', @level2type=N'COLUMN',@level2name=N'order_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_header', N'COLUMN',N'ship_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Estimated shipment date from the vendor.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_header', @level2type=N'COLUMN',@level2name=N'ship_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_header', N'COLUMN',N'sub_total'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'purchase order subtotal. Computed as SUM(purchase_order_detail.line_total)for the appropriate purchase_order_id.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_header', @level2type=N'COLUMN',@level2name=N'sub_total'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_header', N'COLUMN',N'tax_amt'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tax amount.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_header', @level2type=N'COLUMN',@level2name=N'tax_amt'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_header', N'COLUMN',N'freight'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Shipping cost.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_header', @level2type=N'COLUMN',@level2name=N'freight'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_header', N'COLUMN',N'total_due'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Total due to vendor. Computed as Subtotal + tax_amt + freight.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_header', @level2type=N'COLUMN',@level2name=N'total_due'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_header', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_header', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_header', N'INDEX',N'IX_purchase_order_header_employee_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nonclustered index.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_header', @level2type=N'INDEX',@level2name=N'IX_purchase_order_header_employee_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_header', N'INDEX',N'IX_purchase_order_header_vendor_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nonclustered index.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_header', @level2type=N'INDEX',@level2name=N'IX_purchase_order_header_vendor_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_header', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'General purchase order information. See purchase_order_detail.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_header'
GO