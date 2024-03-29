﻿SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[production].[transaction_history]') AND type in (N'U'))
BEGIN
CREATE TABLE [production].[transaction_history](
    [transaction_id] [int] IDENTITY(100000,1) NOT NULL,
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
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'transaction_history', N'COLUMN',N'transaction_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for transaction_history records.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'transaction_history', @level2type=N'COLUMN',@level2name=N'transaction_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'transaction_history', N'COLUMN',N'product_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'product identification number. Foreign key to product.product_id.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'transaction_history', @level2type=N'COLUMN',@level2name=N'product_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'transaction_history', N'COLUMN',N'reference_order_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'purchase order, sales order, or work order identification number.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'transaction_history', @level2type=N'COLUMN',@level2name=N'reference_order_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'transaction_history', N'COLUMN',N'reference_order_line_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Line number associated with the purchase order, sales order, or work order.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'transaction_history', @level2type=N'COLUMN',@level2name=N'reference_order_line_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'transaction_history', N'COLUMN',N'transaction_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time of the transaction.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'transaction_history', @level2type=N'COLUMN',@level2name=N'transaction_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'transaction_history', N'COLUMN',N'transaction_type'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'W = work_order, S = sales_order, P = purchase_order' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'transaction_history', @level2type=N'COLUMN',@level2name=N'transaction_type'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'transaction_history', N'COLUMN',N'quantity'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'product quantity.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'transaction_history', @level2type=N'COLUMN',@level2name=N'quantity'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'transaction_history', N'COLUMN',N'actual_cost'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'product cost.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'transaction_history', @level2type=N'COLUMN',@level2name=N'actual_cost'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'transaction_history', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'transaction_history', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'transaction_history', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Record of each purchase order, sales order, or work order transaction year to date.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'transaction_history'
GO
