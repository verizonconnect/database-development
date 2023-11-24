/****** Object:  Table [sales].[sales_tax_rate]    Script Date: 16/11/2023 08:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[sales].[sales_tax_rate]') AND type in (N'U'))
BEGIN
CREATE TABLE [sales].[sales_tax_rate](
    [sales_tax_rate_id] [int] IDENTITY(1,1) NOT NULL,
    [state_province_id] [int] NOT NULL,
    [tax_type] [tinyint] NOT NULL,
    [tax_rate] [smallmoney] NOT NULL,
    [name] [common].[name] NOT NULL,
    [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO
/****** Object:  Index [AK_sales_tax_rate_rowguid]    Script Date: 16/11/2023 08:45:05 ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[sales].[sales_tax_rate]') AND name = N'AK_sales_tax_rate_rowguid')
CREATE UNIQUE NONCLUSTERED INDEX [AK_sales_tax_rate_rowguid] ON [sales].[sales_tax_rate]
(
    [rowguid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [AK_sales_tax_rate_state_province_id_tax_type]    Script Date: 16/11/2023 08:45:05 ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[sales].[sales_tax_rate]') AND name = N'AK_sales_tax_rate_state_province_id_tax_type')
CREATE UNIQUE NONCLUSTERED INDEX [AK_sales_tax_rate_state_province_id_tax_type] ON [sales].[sales_tax_rate]
(
    [state_province_id] ASC,
    [tax_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_tax_rate', N'COLUMN',N'sales_tax_rate_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for sales_tax_rate records.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_tax_rate', @level2type=N'COLUMN',@level2name=N'sales_tax_rate_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_tax_rate', N'COLUMN',N'state_province_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'state, province, or country/region the sales tax applies to.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_tax_rate', @level2type=N'COLUMN',@level2name=N'state_province_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_tax_rate', N'COLUMN',N'tax_type'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1 = Tax applied to retail transactions, 2 = Tax applied to wholesale transactions, 3 = Tax applied to all sales (retail and wholesale) transactions.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_tax_rate', @level2type=N'COLUMN',@level2name=N'tax_type'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_tax_rate', N'COLUMN',N'tax_rate'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tax rate amount.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_tax_rate', @level2type=N'COLUMN',@level2name=N'tax_rate'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_tax_rate', N'COLUMN',N'name'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tax rate description.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_tax_rate', @level2type=N'COLUMN',@level2name=N'name'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_tax_rate', N'COLUMN',N'rowguid'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_tax_rate', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_tax_rate', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_tax_rate', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_tax_rate', N'INDEX',N'AK_sales_tax_rate_rowguid'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique nonclustered index. Used to support replication samples.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_tax_rate', @level2type=N'INDEX',@level2name=N'AK_sales_tax_rate_rowguid'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_tax_rate', N'INDEX',N'AK_sales_tax_rate_state_province_id_tax_type'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique nonclustered index.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_tax_rate', @level2type=N'INDEX',@level2name=N'AK_sales_tax_rate_state_province_id_tax_type'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_tax_rate', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tax rate lookup table.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_tax_rate'
GO
