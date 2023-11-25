
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[production].[product_cost_history]') AND type in (N'U'))
BEGIN
CREATE TABLE [production].[product_cost_history](
    [product_id] [int] NOT NULL,
    [start_date] [datetime] NOT NULL,
    [end_date] [datetime] NULL,
    [standard_cost] [money] NOT NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_cost_history', N'COLUMN',N'product_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'product identification number. Foreign key to product.product_id' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_cost_history', @level2type=N'COLUMN',@level2name=N'product_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_cost_history', N'COLUMN',N'start_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'product cost start date.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_cost_history', @level2type=N'COLUMN',@level2name=N'start_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_cost_history', N'COLUMN',N'end_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'product cost end date.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_cost_history', @level2type=N'COLUMN',@level2name=N'end_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_cost_history', N'COLUMN',N'standard_cost'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Standard cost of the product.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_cost_history', @level2type=N'COLUMN',@level2name=N'standard_cost'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_cost_history', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_cost_history', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_cost_history', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Changes in the cost of a product over time.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_cost_history'
GO
