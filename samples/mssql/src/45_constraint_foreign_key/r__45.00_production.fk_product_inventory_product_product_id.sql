
IF OBJECT_ID('[production].[fk_product_inventory_product_product_id]', 'F') IS NULL
BEGIN
    ALTER TABLE [production].[product_inventory]  
    ADD CONSTRAINT [fk_product_inventory_product_product_id] 
    FOREIGN KEY (product_id)
    REFERENCES [production].[product] (product_id)
    ON DELETE NO ACTION;
END;
GO

ALTER TABLE [production].[product_inventory] 
CHECK CONSTRAINT [fk_product_inventory_product_product_id];
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'product_inventory'
                                              , N'CONSTRAINT',N'fk_product_inventory_product_product_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Foreign key constraint referencing product.product_id.'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'product_inventory'
                                  , @level2type=N'CONSTRAINT',@level2name=N'fk_product_inventory_product_product_id'
GO
