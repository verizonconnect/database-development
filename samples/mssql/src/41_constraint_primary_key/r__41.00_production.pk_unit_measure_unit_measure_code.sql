
IF OBJECT_ID('[production].[pk_unit_measure_unit_measure_code]', 'PK') IS NULL
    BEGIN
        ALTER TABLE [production].[unit_measure]
        ADD CONSTRAINT [pk_unit_measure_unit_measure_code]
        PRIMARY KEY CLUSTERED (unit_measure_code ASC)
        WITH ( DATA_COMPRESSION = NONE)
        ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'unit_measure'
                                              , N'CONSTRAINT',N'pk_unit_measure_unit_measure_code'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Primary key (clustered) constraint'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'unit_measure'
                                  , @level2type=N'CONSTRAINT',@level2name=N'pk_unit_measure_unit_measure_code'
GO
