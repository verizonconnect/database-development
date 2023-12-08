
IF OBJECT_ID('[sales].[pk_country_region_currency_country_region_code_currency_code]', 'PK') IS NULL
    BEGIN
        ALTER TABLE [sales].[country_region_currency]
        ADD CONSTRAINT [pk_country_region_currency_country_region_code_currency_code]
        PRIMARY KEY CLUSTERED (country_region_code ASC, currency_code ASC)
        WITH ( DATA_COMPRESSION = NONE)
        ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'country_region_currency'
                                              , N'CONSTRAINT',N'pk_country_region_currency_country_region_code_currency_code'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Primary key (clustered) constraint'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'country_region_currency'
                                  , @level2type=N'CONSTRAINT',@level2name=N'pk_country_region_currency_country_region_code_currency_code'
GO
