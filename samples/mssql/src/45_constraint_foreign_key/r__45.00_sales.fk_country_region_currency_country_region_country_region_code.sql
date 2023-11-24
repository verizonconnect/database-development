
IF OBJECT_ID('[sales].[fk_country_region_currency_country_region_country_region_code]', 'F') IS NULL
BEGIN
    ALTER TABLE [sales].[country_region_currency]  
    ADD CONSTRAINT [fk_country_region_currency_country_region_country_region_code] 
    FOREIGN KEY (country_region_code)
    REFERENCES [person].[country_region] (country_region_code)
    ON DELETE NO ACTION;
END;
GO

ALTER TABLE [sales].[country_region_currency] 
CHECK CONSTRAINT [fk_country_region_currency_country_region_country_region_code];
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'country_region_currency'
                                              , N'CONSTRAINT',N'fk_country_region_currency_country_region_country_region_code'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Foreign key constraint referencing country_region.country_region_code.'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'country_region_currency'
                                  , @level2type=N'CONSTRAINT',@level2name=N'fk_country_region_currency_country_region_country_region_code'
GO
