
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[sales].[sales_territory]') AND type in (N'U'))
BEGIN
CREATE TABLE [sales].[sales_territory](
    [territory_id] [int] IDENTITY(1,1) NOT NULL,
    [name] [common].[name] NOT NULL,
    [country_region_code] [nvarchar](3) NOT NULL,
    [group] [nvarchar](50) NOT NULL,
    [sales_ytd] [money] NOT NULL,
    [sales_last_year] [money] NOT NULL,
    [cost_ytd] [money] NOT NULL,
    [cost_last_year] [money] NOT NULL,
    [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[sales].[sales_territory]') AND name = N'AK_sales_territory_name')
CREATE UNIQUE NONCLUSTERED INDEX [AK_sales_territory_name] ON [sales].[sales_territory]
(
    [name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[sales].[sales_territory]') AND name = N'AK_sales_territory_rowguid')
CREATE UNIQUE NONCLUSTERED INDEX [AK_sales_territory_rowguid] ON [sales].[sales_territory]
(
    [rowguid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_territory', N'COLUMN',N'territory_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for sales_territory records.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_territory', @level2type=N'COLUMN',@level2name=N'territory_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_territory', N'COLUMN',N'name'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'sales territory description' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_territory', @level2type=N'COLUMN',@level2name=N'name'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_territory', N'COLUMN',N'country_region_code'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ISO standard country or region code. Foreign key to country_region.country_region_code. ' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_territory', @level2type=N'COLUMN',@level2name=N'country_region_code'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_territory', N'COLUMN',N'Group'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Geographic area to which the sales territory belong.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_territory', @level2type=N'COLUMN',@level2name=N'Group'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_territory', N'COLUMN',N'sales_ytd'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'sales in the territory year to date.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_territory', @level2type=N'COLUMN',@level2name=N'sales_ytd'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_territory', N'COLUMN',N'sales_last_year'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'sales in the territory the previous year.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_territory', @level2type=N'COLUMN',@level2name=N'sales_last_year'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_territory', N'COLUMN',N'cost_ytd'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Business costs in the territory year to date.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_territory', @level2type=N'COLUMN',@level2name=N'cost_ytd'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_territory', N'COLUMN',N'cost_last_year'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Business costs in the territory the previous year.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_territory', @level2type=N'COLUMN',@level2name=N'cost_last_year'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_territory', N'COLUMN',N'rowguid'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_territory', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_territory', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_territory', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_territory', N'INDEX',N'AK_sales_territory_name'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique nonclustered index.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_territory', @level2type=N'INDEX',@level2name=N'AK_sales_territory_name'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_territory', N'INDEX',N'AK_sales_territory_rowguid'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique nonclustered index. Used to support replication samples.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_territory', @level2type=N'INDEX',@level2name=N'AK_sales_territory_rowguid'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_territory', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'sales territory lookup table.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_territory'
GO
