
IF OBJECT_ID('[sales].[fk_sales_tax_rate_state_province_state_province_id]', 'F') IS NULL
BEGIN
    ALTER TABLE [sales].[sales_tax_rate]  
    ADD CONSTRAINT [fk_sales_tax_rate_state_province_state_province_id] 
    FOREIGN KEY (state_province_id)
    REFERENCES [person].[state_province] (state_province_id)
    ON DELETE NO ACTION;
END;
GO

ALTER TABLE [sales].[sales_tax_rate] 
CHECK CONSTRAINT [fk_sales_tax_rate_state_province_state_province_id];
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'sales_tax_rate'
                                              , N'CONSTRAINT',N'fk_sales_tax_rate_state_province_state_province_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Foreign key constraint referencing state_province.state_province_id.'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'sales_tax_rate'
                                  , @level2type=N'CONSTRAINT',@level2name=N'fk_sales_tax_rate_state_province_state_province_id'
GO
