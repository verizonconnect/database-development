SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[production].[work_order_routing]') AND type in (N'U'))
BEGIN
CREATE TABLE [production].[work_order_routing](
    [work_order_id] [int] NOT NULL,
    [product_id] [int] NOT NULL,
    [operation_sequence] [smallint] NOT NULL,
    [location_id] [smallint] NOT NULL,
    [scheduled_start_date] [datetime] NOT NULL,
    [scheduled_end_date] [datetime] NOT NULL,
    [actual_start_date] [datetime] NULL,
    [actual_end_date] [datetime] NULL,
    [actual_resource_hrs] [decimal](9, 4) NULL,
    [planned_cost] [money] NOT NULL,
    [actual_cost] [money] NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'work_order_routing', N'COLUMN',N'work_order_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. Foreign key to work_order.work_order_id.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'work_order_routing', @level2type=N'COLUMN',@level2name=N'work_order_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'work_order_routing', N'COLUMN',N'product_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. Foreign key to product.product_id.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'work_order_routing', @level2type=N'COLUMN',@level2name=N'product_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'work_order_routing', N'COLUMN',N'operation_sequence'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. Indicates the manufacturing process sequence.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'work_order_routing', @level2type=N'COLUMN',@level2name=N'operation_sequence'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'work_order_routing', N'COLUMN',N'location_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Manufacturing location where the part is processed. Foreign key to location.location_id.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'work_order_routing', @level2type=N'COLUMN',@level2name=N'location_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'work_order_routing', N'COLUMN',N'scheduled_start_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Planned manufacturing start date.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'work_order_routing', @level2type=N'COLUMN',@level2name=N'scheduled_start_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'work_order_routing', N'COLUMN',N'scheduled_end_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Planned manufacturing end date.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'work_order_routing', @level2type=N'COLUMN',@level2name=N'scheduled_end_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'work_order_routing', N'COLUMN',N'actual_start_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Actual start date.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'work_order_routing', @level2type=N'COLUMN',@level2name=N'actual_start_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'work_order_routing', N'COLUMN',N'actual_end_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Actual end date.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'work_order_routing', @level2type=N'COLUMN',@level2name=N'actual_end_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'work_order_routing', N'COLUMN',N'actual_resource_hrs'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of manufacturing hours used.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'work_order_routing', @level2type=N'COLUMN',@level2name=N'actual_resource_hrs'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'work_order_routing', N'COLUMN',N'planned_cost'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Estimated manufacturing cost.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'work_order_routing', @level2type=N'COLUMN',@level2name=N'planned_cost'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'work_order_routing', N'COLUMN',N'actual_cost'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Actual manufacturing cost.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'work_order_routing', @level2type=N'COLUMN',@level2name=N'actual_cost'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'work_order_routing', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'work_order_routing', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'work_order_routing', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Work order details.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'work_order_routing'
GO
