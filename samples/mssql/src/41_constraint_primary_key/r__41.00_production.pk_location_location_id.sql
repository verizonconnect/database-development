
IF OBJECT_ID('[production].[pk_location_location_id]', 'PK') IS NULL
    BEGIN
        ALTER TABLE [production].[location]
        ADD CONSTRAINT [pk_location_location_id]
        PRIMARY KEY CLUSTERED (location_id ASC)
        WITH ( DATA_COMPRESSION = NONE)
        ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'location'
                                              , N'CONSTRAINT',N'pk_location_location_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Primary key (clustered) constraint'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'location'
                                  , @level2type=N'CONSTRAINT',@level2name=N'pk_location_location_id'
GO
