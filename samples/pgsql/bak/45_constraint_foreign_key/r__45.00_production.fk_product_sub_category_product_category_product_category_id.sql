
IF OBJECT_ID('[production].[fk_product_sub_category_product_category_product_category_id]', 'F') IS NULL
BEGIN
    ALTER TABLE [production].[product_sub_category]  
    ADD CONSTRAINT [fk_product_sub_category_product_category_product_category_id] 
    FOREIGN KEY (product_category_id)
    REFERENCES [production].[product_category] (product_category_id)
    ON DELETE NO ACTION;
END;
GO

ALTER TABLE [production].[product_sub_category] 
CHECK CONSTRAINT [fk_product_sub_category_product_category_product_category_id];
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'product_sub_category'
                                              , N'CONSTRAINT',N'fk_product_sub_category_product_category_product_category_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Foreign key constraint referencing product_category.product_category_id.'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'product_sub_category'
                                  , @level2type=N'CONSTRAINT',@level2name=N'fk_product_sub_category_product_category_product_category_id'
GO
