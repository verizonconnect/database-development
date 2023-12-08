
IF OBJECT_ID('[purchasing].[fk_product_vendor_product_product_id]', 'F') IS NULL
BEGIN
    ALTER TABLE [purchasing].[product_vendor]  
    ADD CONSTRAINT [fk_product_vendor_product_product_id] 
    FOREIGN KEY (product_id)
    REFERENCES [production].[product] (product_id)
    ON DELETE NO ACTION;
END;
GO

ALTER TABLE [purchasing].[product_vendor] 
CHECK CONSTRAINT [fk_product_vendor_product_product_id];
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'purchasing'
                                              , N'TABLE',N'product_vendor'
                                              , N'CONSTRAINT',N'fk_product_vendor_product_product_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Foreign key constraint referencing product.product_id.'
                                  , @level0type=N'SCHEMA',@level0name=N'purchasing'
                                  , @level1type=N'TABLE',@level1name=N'product_vendor'
                                  , @level2type=N'CONSTRAINT',@level2name=N'fk_product_vendor_product_product_id'
GO
