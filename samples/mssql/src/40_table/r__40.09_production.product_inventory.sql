SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[production].[product_inventory]') AND type in (N'U'))
BEGIN
CREATE TABLE [production].[product_inventory](
    [product_id] [int] NOT NULL,
    [location_id] [smallint] NOT NULL,
    [shelf] [nvarchar](10) NOT NULL,
    [bin] [tinyint] NOT NULL,
    [quantity] [smallint] NOT NULL,
    [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_inventory', N'COLUMN',N'product_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'product identification number. Foreign key to product.product_id.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_inventory', @level2type=N'COLUMN',@level2name=N'product_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_inventory', N'COLUMN',N'location_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Inventory location identification number. Foreign key to location.location_id. ' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_inventory', @level2type=N'COLUMN',@level2name=N'location_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_inventory', N'COLUMN',N'shelf'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Storage compartment within an inventory location.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_inventory', @level2type=N'COLUMN',@level2name=N'shelf'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_inventory', N'COLUMN',N'Bin'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Storage container on a shelf in an inventory location.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_inventory', @level2type=N'COLUMN',@level2name=N'Bin'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_inventory', N'COLUMN',N'quantity'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'quantity of products in the inventory location.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_inventory', @level2type=N'COLUMN',@level2name=N'quantity'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_inventory', N'COLUMN',N'rowguid'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_inventory', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_inventory', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_inventory', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_inventory', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'product inventory information.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_inventory'
GO
