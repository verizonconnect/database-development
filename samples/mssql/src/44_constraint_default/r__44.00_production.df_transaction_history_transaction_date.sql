
IF OBJECT_ID('[production].[df_transaction_history_transaction_date]', 'D') IS NULL
    BEGIN
        ALTER TABLE [production].[transaction_history]
        ADD CONSTRAINT [df_transaction_history_transaction_date]
        DEFAULT (getdate())
        FOR [transaction_date];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'transaction_history'
                                              , N'CONSTRAINT',N'df_transaction_history_transaction_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Default constraint value of GETDATE()'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'transaction_history'
                                  , @level2type=N'CONSTRAINT',@level2name=N'df_transaction_history_transaction_date'
GO
