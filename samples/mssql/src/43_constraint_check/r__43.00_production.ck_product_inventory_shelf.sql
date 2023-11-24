
IF OBJECT_ID('[production].[ck_product_inventory_shelf]', 'C') IS NULL
    BEGIN
        ALTER TABLE [production].[product_inventory]
        WITH NOCHECK
        ADD CONSTRAINT [ck_product_inventory_shelf]
        CHECK ([shelf] like '[A-Za-z]' OR [shelf]='N/A');
    END;
GO

ALTER TABLE [production].[product_inventory] 
CHECK CONSTRAINT [ck_product_inventory_shelf]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'product_inventory'
                                              , N'CONSTRAINT',N'ck_product_inventory_shelf'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [shelf] like ''[A-Za-z]'' OR [shelf]=''N/A'''
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'product_inventory'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_product_inventory_shelf'
GO
