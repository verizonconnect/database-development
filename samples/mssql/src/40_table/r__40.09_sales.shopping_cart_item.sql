﻿SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[sales].[shopping_cart_item]') AND type in (N'U'))
BEGIN
CREATE TABLE [sales].[shopping_cart_item](
    [shopping_cart_item_id] [int] IDENTITY(1,1) NOT NULL,
    [shopping_cart_id] [nvarchar](50) NOT NULL,
    [quantity] [int] NOT NULL,
    [product_id] [int] NOT NULL,
    [created_date] [datetime] NOT NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'shopping_cart_item', N'COLUMN',N'shopping_cart_item_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for shopping_cart_item records.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'shopping_cart_item', @level2type=N'COLUMN',@level2name=N'shopping_cart_item_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'shopping_cart_item', N'COLUMN',N'shopping_cart_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'shopping cart identification number.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'shopping_cart_item', @level2type=N'COLUMN',@level2name=N'shopping_cart_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'shopping_cart_item', N'COLUMN',N'quantity'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'product quantity ordered.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'shopping_cart_item', @level2type=N'COLUMN',@level2name=N'quantity'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'shopping_cart_item', N'COLUMN',N'product_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'product ordered. Foreign key to product.product_id.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'shopping_cart_item', @level2type=N'COLUMN',@level2name=N'product_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'shopping_cart_item', N'COLUMN',N'created_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date the time the record was created.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'shopping_cart_item', @level2type=N'COLUMN',@level2name=N'created_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'shopping_cart_item', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'shopping_cart_item', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'shopping_cart_item', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Contains online customer orders until the order is submitted or cancelled.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'shopping_cart_item'
GO
