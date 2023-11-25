
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[sales].[special_offer]') AND type in (N'U'))
BEGIN
CREATE TABLE [sales].[special_offer](
    [special_offer_id] [int] IDENTITY(1,1) NOT NULL,
    [description] [nvarchar](255) NOT NULL,
    [discount_pct] [smallmoney] NOT NULL,
    [type] [nvarchar](50) NOT NULL,
    [category] [nvarchar](50) NOT NULL,
    [start_date] [datetime] NOT NULL,
    [end_date] [datetime] NOT NULL,
    [min_qty] [int] NOT NULL,
    [max_qty] [int] NULL,
    [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[sales].[special_offer]') AND name = N'AK_special_offer_rowguid')
CREATE UNIQUE NONCLUSTERED INDEX [AK_special_offer_rowguid] ON [sales].[special_offer]
(
    [rowguid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'special_offer', N'COLUMN',N'special_offer_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for special_offer records.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'special_offer', @level2type=N'COLUMN',@level2name=N'special_offer_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'special_offer', N'COLUMN',N'description'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Discount description.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'special_offer', @level2type=N'COLUMN',@level2name=N'description'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'special_offer', N'COLUMN',N'discount_pct'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Discount precentage.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'special_offer', @level2type=N'COLUMN',@level2name=N'discount_pct'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'special_offer', N'COLUMN',N'type'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Discount type category.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'special_offer', @level2type=N'COLUMN',@level2name=N'type'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'special_offer', N'COLUMN',N'category'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Group the discount applies to such as Reseller or customer.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'special_offer', @level2type=N'COLUMN',@level2name=N'category'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'special_offer', N'COLUMN',N'start_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Discount start date.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'special_offer', @level2type=N'COLUMN',@level2name=N'start_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'special_offer', N'COLUMN',N'end_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Discount end date.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'special_offer', @level2type=N'COLUMN',@level2name=N'end_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'special_offer', N'COLUMN',N'min_qty'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Minimum discount percent allowed.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'special_offer', @level2type=N'COLUMN',@level2name=N'min_qty'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'special_offer', N'COLUMN',N'max_qty'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Maximum discount percent allowed.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'special_offer', @level2type=N'COLUMN',@level2name=N'max_qty'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'special_offer', N'COLUMN',N'rowguid'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'special_offer', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'special_offer', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'special_offer', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'special_offer', N'INDEX',N'AK_special_offer_rowguid'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique nonclustered index. Used to support replication samples.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'special_offer', @level2type=N'INDEX',@level2name=N'AK_special_offer_rowguid'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'special_offer', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sale discounts lookup table.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'special_offer'
GO
