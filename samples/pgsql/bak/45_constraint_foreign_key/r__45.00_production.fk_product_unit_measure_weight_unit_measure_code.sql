
IF OBJECT_ID('[production].[fk_product_unit_measure_weight_unit_measure_code]', 'F') IS NULL
BEGIN
    ALTER TABLE [production].[product]  
    ADD CONSTRAINT [fk_product_unit_measure_weight_unit_measure_code] 
    FOREIGN KEY (weight_unit_measure_code)
    REFERENCES [production].[unit_measure] (unit_measure_code)
    ON DELETE NO ACTION;
END;
GO

ALTER TABLE [production].[product] 
CHECK CONSTRAINT [fk_product_unit_measure_weight_unit_measure_code];
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'product'
                                              , N'CONSTRAINT',N'fk_product_unit_measure_weight_unit_measure_code'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Foreign key constraint referencing unit_measure.unit_measure_code.'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'product'
                                  , @level2type=N'CONSTRAINT',@level2name=N'fk_product_unit_measure_weight_unit_measure_code'
GO
