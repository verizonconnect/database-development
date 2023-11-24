
IF OBJECT_ID('[production].[fk_product_product_model_product_model_id]', 'F') IS NULL
BEGIN
    ALTER TABLE [production].[product]  
    ADD CONSTRAINT [fk_product_product_model_product_model_id] 
    FOREIGN KEY (product_model_id)
    REFERENCES [production].[product_model] (product_model_id)
    ON DELETE NO ACTION;
END;
GO

ALTER TABLE [production].[product] 
CHECK CONSTRAINT [fk_product_product_model_product_model_id];
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'product'
                                              , N'CONSTRAINT',N'fk_product_product_model_product_model_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Foreign key constraint referencing product_model.product_model_id.'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'product'
                                  , @level2type=N'CONSTRAINT',@level2name=N'fk_product_product_model_product_model_id'
GO
