
IF OBJECT_ID('[production].[fk_product_product_photo_product_photo_product_photo_id]', 'F') IS NULL
BEGIN
    ALTER TABLE [production].[product_product_photo]  
    ADD CONSTRAINT [fk_product_product_photo_product_photo_product_photo_id] 
    FOREIGN KEY (product_photo_id)
    REFERENCES [production].[product_photo] (product_photo_id)
    ON DELETE NO ACTION;
END;
GO

ALTER TABLE [production].[product_product_photo] 
CHECK CONSTRAINT [fk_product_product_photo_product_photo_product_photo_id];
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'product_product_photo'
                                              , N'CONSTRAINT',N'fk_product_product_photo_product_photo_product_photo_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Foreign key constraint referencing product_photo.product_photo_id.'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'product_product_photo'
                                  , @level2type=N'CONSTRAINT',@level2name=N'fk_product_product_photo_product_photo_product_photo_id'
GO
