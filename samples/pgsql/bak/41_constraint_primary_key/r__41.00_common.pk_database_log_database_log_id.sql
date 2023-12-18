
IF OBJECT_ID('[common].[pk_database_log_database_log_id]', 'PK') IS NULL
    BEGIN
        ALTER TABLE [common].[database_log]
        ADD CONSTRAINT [pk_database_log_database_log_id]
        PRIMARY KEY NONCLUSTERED (database_log_id ASC)
        WITH ( DATA_COMPRESSION = NONE)
        ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'common'
                                              , N'TABLE',N'database_log'
                                              , N'CONSTRAINT',N'pk_database_log_database_log_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Primary key (nonclustered) constraint'
                                  , @level0type=N'SCHEMA',@level0name=N'common'
                                  , @level1type=N'TABLE',@level1name=N'database_log'
                                  , @level2type=N'CONSTRAINT',@level2name=N'pk_database_log_database_log_id'
GO
