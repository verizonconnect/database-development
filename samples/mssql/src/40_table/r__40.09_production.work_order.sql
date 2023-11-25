
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[production].[work_order]') AND type in (N'U'))
BEGIN
CREATE TABLE [production].[work_order](
    [work_order_id] [int] IDENTITY(1,1) NOT NULL,
    [product_id] [int] NOT NULL,
    [order_qty] [int] NOT NULL,
    [stocked_qty]  AS (isnull([order_qty]-[scrapped_qty],(0))),
    [scrapped_qty] [smallint] NOT NULL,
    [start_date] [datetime] NOT NULL,
    [end_date] [datetime] NULL,
    [due_date] [datetime] NOT NULL,
    [scrap_reason_id] [smallint] NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[production].[work_order]') AND name = N'IX_work_order_product_id')
CREATE NONCLUSTERED INDEX [IX_work_order_product_id] ON [production].[work_order]
(
    [product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[production].[work_order]') AND name = N'IX_work_order_scrap_reason_id')
CREATE NONCLUSTERED INDEX [IX_work_order_scrap_reason_id] ON [production].[work_order]
(
    [scrap_reason_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'work_order', N'COLUMN',N'work_order_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for work_order records.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'work_order', @level2type=N'COLUMN',@level2name=N'work_order_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'work_order', N'COLUMN',N'product_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'product identification number. Foreign key to product.product_id.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'work_order', @level2type=N'COLUMN',@level2name=N'product_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'work_order', N'COLUMN',N'order_qty'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'product quantity to build.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'work_order', @level2type=N'COLUMN',@level2name=N'order_qty'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'work_order', N'COLUMN',N'stocked_qty'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'quantity built and put in inventory.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'work_order', @level2type=N'COLUMN',@level2name=N'stocked_qty'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'work_order', N'COLUMN',N'scrapped_qty'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'quantity that failed inspection.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'work_order', @level2type=N'COLUMN',@level2name=N'scrapped_qty'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'work_order', N'COLUMN',N'start_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Work order start date.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'work_order', @level2type=N'COLUMN',@level2name=N'start_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'work_order', N'COLUMN',N'end_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Work order end date.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'work_order', @level2type=N'COLUMN',@level2name=N'end_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'work_order', N'COLUMN',N'due_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Work order due date.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'work_order', @level2type=N'COLUMN',@level2name=N'due_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'work_order', N'COLUMN',N'scrap_reason_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Reason for inspection failure.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'work_order', @level2type=N'COLUMN',@level2name=N'scrap_reason_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'work_order', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'work_order', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'work_order', N'INDEX',N'IX_work_order_product_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nonclustered index.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'work_order', @level2type=N'INDEX',@level2name=N'IX_work_order_product_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'work_order', N'INDEX',N'IX_work_order_scrap_reason_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nonclustered index.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'work_order', @level2type=N'INDEX',@level2name=N'IX_work_order_scrap_reason_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'work_order', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Manufacturing work orders.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'work_order'
GO
