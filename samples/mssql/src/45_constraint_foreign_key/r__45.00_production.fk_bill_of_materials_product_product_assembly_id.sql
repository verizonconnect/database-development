
IF OBJECT_ID('[production].[fk_bill_of_materials_product_product_assembly_id]', 'F') IS NULL
BEGIN
    ALTER TABLE [production].[bill_of_materials]  
    ADD CONSTRAINT [fk_bill_of_materials_product_product_assembly_id] 
    FOREIGN KEY (product_assembly_id)
    REFERENCES [production].[product] (product_id)
    ON DELETE NO ACTION;
END;
GO

ALTER TABLE [production].[bill_of_materials] 
CHECK CONSTRAINT [fk_bill_of_materials_product_product_assembly_id];
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'bill_of_materials'
                                              , N'CONSTRAINT',N'fk_bill_of_materials_product_product_assembly_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Foreign key constraint referencing product.product_assembly_id.'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'bill_of_materials'
                                  , @level2type=N'CONSTRAINT',@level2name=N'fk_bill_of_materials_product_product_assembly_id'
GO
