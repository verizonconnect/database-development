SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[sales].[sales_order_header_sales_reason]') AND type in (N'U'))
BEGIN
CREATE TABLE [sales].[sales_order_header_sales_reason](
    [sales_order_id] [int] NOT NULL,
    [sales_reason_id] [int] NOT NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_header_sales_reason', N'COLUMN',N'sales_order_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. Foreign key to sales_order_header.sales_order_id.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_header_sales_reason', @level2type=N'COLUMN',@level2name=N'sales_order_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_header_sales_reason', N'COLUMN',N'sales_reason_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. Foreign key to sales_reason.sales_reason_id.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_header_sales_reason', @level2type=N'COLUMN',@level2name=N'sales_reason_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_header_sales_reason', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_header_sales_reason', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_header_sales_reason', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Cross-reference table mapping sales orders to sales reason codes.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_header_sales_reason'
GO
