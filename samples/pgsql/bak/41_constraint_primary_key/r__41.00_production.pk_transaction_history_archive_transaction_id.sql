
IF OBJECT_ID('[production].[pk_transaction_history_archive_transaction_id]', 'PK') IS NULL
    BEGIN
        ALTER TABLE [production].[transaction_history_archive]
        ADD CONSTRAINT [pk_transaction_history_archive_transaction_id]
        PRIMARY KEY CLUSTERED (transaction_id ASC)
        WITH ( DATA_COMPRESSION = NONE)
        ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'transaction_history_archive'
                                              , N'CONSTRAINT',N'pk_transaction_history_archive_transaction_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Primary key (clustered) constraint'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'transaction_history_archive'
                                  , @level2type=N'CONSTRAINT',@level2name=N'pk_transaction_history_archive_transaction_id'
GO
