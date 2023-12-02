SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[sales].[sales_order_header]') AND type in (N'U'))
BEGIN
CREATE TABLE [sales].[sales_order_header](
    [sales_order_id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
    [revision_number] [tinyint] NOT NULL,
    [order_date] [datetime] NOT NULL,
    [due_date] [datetime] NOT NULL,
    [ship_date] [datetime] NULL,
    [status] [tinyint] NOT NULL,
    [online_order_flag] [common].[flag] NOT NULL,
    [sales_order_number]  AS (isnull(N'SO'+CONVERT([nvarchar](23),[sales_order_id]),N'*** ERROR ***')),
    [purchase_order_number] [common].[order_number] NULL,
    [account_number] [common].[account_number] NULL,
    [customer_id] [int] NOT NULL,
    [sales_person_id] [int] NULL,
    [territory_id] [int] NULL,
    [bill_to_address_id] [int] NOT NULL,
    [ship_to_address_id] [int] NOT NULL,
    [ship_method_id] [int] NOT NULL,
    [credit_card_id] [int] NULL,
    [credit_card_approval_code] [varchar](15) NULL,
    [currency_rate_id] [int] NULL,
    [sub_total] [money] NOT NULL,
    [tax_amt] [money] NOT NULL,
    [freight] [money] NOT NULL,
    [total_due]  AS (isnull(([sub_total]+[tax_amt])+[freight],(0))),
    [comment] [nvarchar](128) NULL,
    [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_header', N'COLUMN',N'sales_order_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_header', @level2type=N'COLUMN',@level2name=N'sales_order_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_header', N'COLUMN',N'revision_number'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Incremental number to track changes to the sales order over time.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_header', @level2type=N'COLUMN',@level2name=N'revision_number'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_header', N'COLUMN',N'order_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Dates the sales order was created.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_header', @level2type=N'COLUMN',@level2name=N'order_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_header', N'COLUMN',N'due_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date the order is due to the customer.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_header', @level2type=N'COLUMN',@level2name=N'due_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_header', N'COLUMN',N'ship_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date the order was shipped to the customer.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_header', @level2type=N'COLUMN',@level2name=N'ship_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_header', N'COLUMN',N'status'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Order current status. 1 = In process; 2 = Approved; 3 = Backordered; 4 = rejected; 5 = Shipped; 6 = Cancelled' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_header', @level2type=N'COLUMN',@level2name=N'status'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_header', N'COLUMN',N'online_order_flag'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 = Order placed by sales person. 1 = Order placed online by customer.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_header', @level2type=N'COLUMN',@level2name=N'online_order_flag'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_header', N'COLUMN',N'sales_order_number'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique sales order identification number.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_header', @level2type=N'COLUMN',@level2name=N'sales_order_number'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_header', N'COLUMN',N'purchase_order_number'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'customer purchase order number reference. ' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_header', @level2type=N'COLUMN',@level2name=N'purchase_order_number'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_header', N'COLUMN',N'account_number'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Financial accounting number reference.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_header', @level2type=N'COLUMN',@level2name=N'account_number'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_header', N'COLUMN',N'customer_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'customer identification number. Foreign key to customer.business_entity_id.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_header', @level2type=N'COLUMN',@level2name=N'customer_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_header', N'COLUMN',N'sales_person_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'sales person who created the sales order. Foreign key to sales_person.business_entity_id.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_header', @level2type=N'COLUMN',@level2name=N'sales_person_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_header', N'COLUMN',N'territory_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Territory in which the sale was made. Foreign key to sales_territory.salesterritory_id.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_header', @level2type=N'COLUMN',@level2name=N'territory_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_header', N'COLUMN',N'bill_to_address_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'customer billing address. Foreign key to address.address_id.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_header', @level2type=N'COLUMN',@level2name=N'bill_to_address_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_header', N'COLUMN',N'ship_to_address_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'customer shipping address. Foreign key to address.address_id.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_header', @level2type=N'COLUMN',@level2name=N'ship_to_address_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_header', N'COLUMN',N'ship_method_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Shipping method. Foreign key to ship_method.ship_method_id.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_header', @level2type=N'COLUMN',@level2name=N'ship_method_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_header', N'COLUMN',N'credit_card_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Credit card identification number. Foreign key to credit_card.credit_card_id.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_header', @level2type=N'COLUMN',@level2name=N'credit_card_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_header', N'COLUMN',N'credit_card_approval_code'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Approval code provided by the credit card company.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_header', @level2type=N'COLUMN',@level2name=N'credit_card_approval_code'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_header', N'COLUMN',N'currency_rate_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'currency exchange rate used. Foreign key to currency_rate.currency_rate_id.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_header', @level2type=N'COLUMN',@level2name=N'currency_rate_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_header', N'COLUMN',N'sub_total'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'sales subtotal. Computed as SUM(sales_order_detail.line_total)for the appropriate sales_order_id.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_header', @level2type=N'COLUMN',@level2name=N'sub_total'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_header', N'COLUMN',N'tax_amt'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tax amount.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_header', @level2type=N'COLUMN',@level2name=N'tax_amt'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_header', N'COLUMN',N'freight'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Shipping cost.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_header', @level2type=N'COLUMN',@level2name=N'freight'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_header', N'COLUMN',N'total_due'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Total due from customer. Computed as Subtotal + tax_amt + freight.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_header', @level2type=N'COLUMN',@level2name=N'total_due'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_header', N'COLUMN',N'comment'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'sales representative comments.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_header', @level2type=N'COLUMN',@level2name=N'comment'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_header', N'COLUMN',N'rowguid'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_header', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_header', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_header', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_header', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'General sales order information.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_header'
GO
