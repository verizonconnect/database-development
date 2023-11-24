
IF OBJECT_ID('[production].[ck_product_inventory_Bin]', 'C') IS NULL
    BEGIN
        ALTER TABLE [production].[product_inventory]
        WITH NOCHECK
        ADD CONSTRAINT [ck_product_inventory_Bin]
        CHECK ([bin]>=(0) AND [bin]<=(100));
    END;
GO

ALTER TABLE [production].[product_inventory] 
CHECK CONSTRAINT [ck_product_inventory_Bin]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'product_inventory'
                                              , N'CONSTRAINT',N'ck_product_inventory_Bin'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [bin] BETWEEN (0) AND (100)'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'product_inventory'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_product_inventory_Bin'
GO
