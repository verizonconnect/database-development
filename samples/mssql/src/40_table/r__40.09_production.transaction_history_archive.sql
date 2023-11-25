
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[production].[transaction_history_archive]') AND type in (N'U'))
BEGIN
CREATE TABLE [production].[transaction_history_archive](
    [transaction_id] [int] NOT NULL,
    [product_id] [int] NOT NULL,
    [reference_order_id] [int] NOT NULL,
    [reference_order_line_id] [int] NOT NULL,
    [transaction_date] [datetime] NOT NULL,
    [transaction_type] [nchar](1) NOT NULL,
    [quantity] [int] NOT NULL,
    [actual_cost] [money] NOT NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[production].[transaction_history_archive]') AND name = N'IX_transaction_history_archive_product_id')
CREATE NONCLUSTERED INDEX [IX_transaction_history_archive_product_id] ON [production].[transaction_history_archive]
(
    [product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[production].[transaction_history_archive]') AND name = N'IX_transaction_history_archive_reference_order_id_reference_order_line_id')
CREATE NONCLUSTERED INDEX [IX_transaction_history_archive_reference_order_id_reference_order_line_id] ON [production].[transaction_history_archive]
(
    [reference_order_id] ASC,
    [reference_order_line_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'transaction_history_archive', N'COLUMN',N'transaction_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for transaction_history_archive records.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'transaction_history_archive', @level2type=N'COLUMN',@level2name=N'transaction_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'transaction_history_archive', N'COLUMN',N'product_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'product identification number. Foreign key to product.product_id.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'transaction_history_archive', @level2type=N'COLUMN',@level2name=N'product_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'transaction_history_archive', N'COLUMN',N'reference_order_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'purchase order, sales order, or work order identification number.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'transaction_history_archive', @level2type=N'COLUMN',@level2name=N'reference_order_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'transaction_history_archive', N'COLUMN',N'reference_order_line_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Line number associated with the purchase order, sales order, or work order.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'transaction_history_archive', @level2type=N'COLUMN',@level2name=N'reference_order_line_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'transaction_history_archive', N'COLUMN',N'transaction_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time of the transaction.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'transaction_history_archive', @level2type=N'COLUMN',@level2name=N'transaction_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'transaction_history_archive', N'COLUMN',N'transaction_type'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'W = Work Order, S = sales Order, P = purchase Order' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'transaction_history_archive', @level2type=N'COLUMN',@level2name=N'transaction_type'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'transaction_history_archive', N'COLUMN',N'quantity'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'product quantity.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'transaction_history_archive', @level2type=N'COLUMN',@level2name=N'quantity'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'transaction_history_archive', N'COLUMN',N'actual_cost'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'product cost.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'transaction_history_archive', @level2type=N'COLUMN',@level2name=N'actual_cost'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'transaction_history_archive', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'transaction_history_archive', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'transaction_history_archive', N'INDEX',N'IX_transaction_history_archive_product_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nonclustered index.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'transaction_history_archive', @level2type=N'INDEX',@level2name=N'IX_transaction_history_archive_product_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'transaction_history_archive', N'INDEX',N'IX_transaction_history_archive_reference_order_id_reference_order_line_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nonclustered index.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'transaction_history_archive', @level2type=N'INDEX',@level2name=N'IX_transaction_history_archive_reference_order_id_reference_order_line_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'transaction_history_archive', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Transactions for previous years.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'transaction_history_archive'
GO
