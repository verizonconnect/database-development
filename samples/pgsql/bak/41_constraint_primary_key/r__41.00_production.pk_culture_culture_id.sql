
IF OBJECT_ID('[production].[pk_culture_culture_id]', 'PK') IS NULL
    BEGIN
        ALTER TABLE [production].[culture]
        ADD CONSTRAINT [pk_culture_culture_id]
        PRIMARY KEY CLUSTERED (culture_id ASC)
        WITH ( DATA_COMPRESSION = NONE)
        ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'culture'
                                              , N'CONSTRAINT',N'pk_culture_culture_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Primary key (clustered) constraint'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'culture'
                                  , @level2type=N'CONSTRAINT',@level2name=N'pk_culture_culture_id'
GO
