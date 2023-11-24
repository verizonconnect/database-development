
IF OBJECT_ID('[person].[pk_country_region_country_region_code]', 'PK') IS NULL
    BEGIN
        ALTER TABLE [person].[country_region]
        ADD CONSTRAINT [pk_country_region_country_region_code]
        PRIMARY KEY CLUSTERED (country_region_code ASC)
        WITH ( DATA_COMPRESSION = NONE)
        ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'person'
                                              , N'TABLE',N'country_region'
                                              , N'CONSTRAINT',N'pk_country_region_country_region_code'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Primary key (clustered) constraint'
                                  , @level0type=N'SCHEMA',@level0name=N'person'
                                  , @level1type=N'TABLE',@level1name=N'country_region'
                                  , @level2type=N'CONSTRAINT',@level2name=N'pk_country_region_country_region_code'
GO
