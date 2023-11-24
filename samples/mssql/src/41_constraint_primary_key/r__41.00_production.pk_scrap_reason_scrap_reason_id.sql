
IF OBJECT_ID('[production].[pk_scrap_reason_scrap_reason_id]', 'PK') IS NULL
    BEGIN
        ALTER TABLE [production].[scrap_reason]
        ADD CONSTRAINT [pk_scrap_reason_scrap_reason_id]
        PRIMARY KEY CLUSTERED (scrap_reason_id ASC)
        WITH ( DATA_COMPRESSION = NONE)
        ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'scrap_reason'
                                              , N'CONSTRAINT',N'pk_scrap_reason_scrap_reason_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Primary key (clustered) constraint'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'scrap_reason'
                                  , @level2type=N'CONSTRAINT',@level2name=N'pk_scrap_reason_scrap_reason_id'
GO
