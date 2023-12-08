
IF OBJECT_ID('[production].[fk_product_model_product_description_culture_product_description_product_description_id]', 'F') IS NULL
BEGIN
    ALTER TABLE [production].[product_model_product_description_culture]  
    ADD CONSTRAINT [fk_product_model_product_description_culture_product_description_product_description_id] 
    FOREIGN KEY (product_description_id)
    REFERENCES [production].[product_description] (product_description_id)
    ON DELETE NO ACTION;
END;
GO

ALTER TABLE [production].[product_model_product_description_culture] 
CHECK CONSTRAINT [fk_product_model_product_description_culture_product_description_product_description_id];
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'product_model_product_description_culture'
                                              , N'CONSTRAINT',N'fk_product_model_product_description_culture_product_description_product_description_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Foreign key constraint referencing product_description.product_description_id.'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'product_model_product_description_culture'
                                  , @level2type=N'CONSTRAINT',@level2name=N'fk_product_model_product_description_culture_product_description_product_description_id'
GO
