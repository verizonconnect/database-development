
IF OBJECT_ID('[sales].[df_currency_rate_modified_date]', 'D') IS NULL
    BEGIN
        ALTER TABLE [sales].[currency_rate]
        ADD CONSTRAINT [df_currency_rate_modified_date]
        DEFAULT (getdate())
        FOR [modified_date];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'currency_rate'
                                              , N'CONSTRAINT',N'df_currency_rate_modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Default constraint value of GETDATE()'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'currency_rate'
                                  , @level2type=N'CONSTRAINT',@level2name=N'df_currency_rate_modified_date'
GO
