
IF OBJECT_ID('[production].[ck_transaction_history_archive_transaction_type]', 'C') IS NULL
    BEGIN
        ALTER TABLE [production].[transaction_history_archive]
        WITH NOCHECK
        ADD CONSTRAINT [ck_transaction_history_archive_transaction_type]
        CHECK (upper([transaction_type])='P' OR upper([transaction_type])='S' OR upper([transaction_type])='W');
    END;
GO

ALTER TABLE [production].[transaction_history_archive] 
CHECK CONSTRAINT [ck_transaction_history_archive_transaction_type]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'transaction_history_archive'
                                              , N'CONSTRAINT',N'ck_transaction_history_archive_transaction_type'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [transaction_type]=''p'' OR [transaction_type]=''s'' OR [transaction_type]=''w'' OR [transaction_type]=''P'' OR [transaction_type]=''S'' OR [transaction_type]=''W'''
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'transaction_history_archive'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_transaction_history_archive_transaction_type'
GO
