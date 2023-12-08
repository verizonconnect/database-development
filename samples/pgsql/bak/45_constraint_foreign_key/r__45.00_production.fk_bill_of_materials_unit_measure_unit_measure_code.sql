
IF OBJECT_ID('[production].[fk_bill_of_materials_unit_measure_unit_measure_code]', 'F') IS NULL
BEGIN
    ALTER TABLE [production].[bill_of_materials]  
    ADD CONSTRAINT [fk_bill_of_materials_unit_measure_unit_measure_code] 
    FOREIGN KEY (unit_measure_code)
    REFERENCES [production].[unit_measure] (unit_measure_code)
    ON DELETE NO ACTION;
END;
GO

ALTER TABLE [production].[bill_of_materials] 
CHECK CONSTRAINT [fk_bill_of_materials_unit_measure_unit_measure_code];
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'bill_of_materials'
                                              , N'CONSTRAINT',N'fk_bill_of_materials_unit_measure_unit_measure_code'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Foreign key constraint referencing unit_measure.unit_measure_code.'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'bill_of_materials'
                                  , @level2type=N'CONSTRAINT',@level2name=N'fk_bill_of_materials_unit_measure_unit_measure_code'
GO
