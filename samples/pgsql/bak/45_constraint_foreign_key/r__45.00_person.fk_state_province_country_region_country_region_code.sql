
IF OBJECT_ID('[person].[fk_state_province_country_region_country_region_code]', 'F') IS NULL
BEGIN
    ALTER TABLE [person].[state_province]  
    ADD CONSTRAINT [fk_state_province_country_region_country_region_code] 
    FOREIGN KEY (country_region_code)
    REFERENCES [person].[country_region] (country_region_code)
    ON DELETE NO ACTION;
END;
GO

ALTER TABLE [person].[state_province] 
CHECK CONSTRAINT [fk_state_province_country_region_country_region_code];
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'person'
                                              , N'TABLE',N'state_province'
                                              , N'CONSTRAINT',N'fk_state_province_country_region_country_region_code'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Foreign key constraint referencing country_region.country_region_code.'
                                  , @level0type=N'SCHEMA',@level0name=N'person'
                                  , @level1type=N'TABLE',@level1name=N'state_province'
                                  , @level2type=N'CONSTRAINT',@level2name=N'fk_state_province_country_region_country_region_code'
GO
