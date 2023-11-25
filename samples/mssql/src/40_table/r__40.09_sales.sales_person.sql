
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[sales].[sales_person]') AND type in (N'U'))
BEGIN
CREATE TABLE [sales].[sales_person](
    [business_entity_id] [int] NOT NULL,
    [territory_id] [int] NULL,
    [sales_quota] [money] NULL,
    [bonus] [money] NOT NULL,
    [commission_pct] [smallmoney] NOT NULL,
    [sales_ytd] [money] NOT NULL,
    [sales_last_year] [money] NOT NULL,
    [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[sales].[sales_person]') AND name = N'AK_sales_person_rowguid')
CREATE UNIQUE NONCLUSTERED INDEX [AK_sales_person_rowguid] ON [sales].[sales_person]
(
    [rowguid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_person', N'COLUMN',N'business_entity_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for sales_person records. Foreign key to employee.business_entity_id' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_person', @level2type=N'COLUMN',@level2name=N'business_entity_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_person', N'COLUMN',N'territory_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Territory currently assigned to. Foreign key to sales_territory.salesterritory_id.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_person', @level2type=N'COLUMN',@level2name=N'territory_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_person', N'COLUMN',N'sales_quota'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Projected yearly sales.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_person', @level2type=N'COLUMN',@level2name=N'sales_quota'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_person', N'COLUMN',N'bonus'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'bonus due if quota is met.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_person', @level2type=N'COLUMN',@level2name=N'bonus'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_person', N'COLUMN',N'commission_pct'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Commision percent received per sale.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_person', @level2type=N'COLUMN',@level2name=N'commission_pct'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_person', N'COLUMN',N'sales_ytd'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'sales total year to date.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_person', @level2type=N'COLUMN',@level2name=N'sales_ytd'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_person', N'COLUMN',N'sales_last_year'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'sales total of previous year.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_person', @level2type=N'COLUMN',@level2name=N'sales_last_year'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_person', N'COLUMN',N'rowguid'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_person', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_person', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_person', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_person', N'INDEX',N'AK_sales_person_rowguid'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique nonclustered index. Used to support replication samples.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_person', @level2type=N'INDEX',@level2name=N'AK_sales_person_rowguid'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_person', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'sales representative current information.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_person'
GO
