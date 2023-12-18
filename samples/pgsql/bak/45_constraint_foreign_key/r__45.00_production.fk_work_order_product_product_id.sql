
IF OBJECT_ID('[production].[fk_work_order_product_product_id]', 'F') IS NULL
BEGIN
    ALTER TABLE [production].[work_order]  
    ADD CONSTRAINT [fk_work_order_product_product_id] 
    FOREIGN KEY (product_id)
    REFERENCES [production].[product] (product_id)
    ON DELETE NO ACTION;
END;
GO

ALTER TABLE [production].[work_order] 
CHECK CONSTRAINT [fk_work_order_product_product_id];
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'work_order'
                                              , N'CONSTRAINT',N'fk_work_order_product_product_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Foreign key constraint referencing product.product_id.'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'work_order'
                                  , @level2type=N'CONSTRAINT',@level2name=N'fk_work_order_product_product_id'
GO
