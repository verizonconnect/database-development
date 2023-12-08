
IF OBJECT_ID('[sales].[pk_currency_rate_currency_rate_id]', 'PK') IS NULL
    BEGIN
        ALTER TABLE [sales].[currency_rate]
        ADD CONSTRAINT [pk_currency_rate_currency_rate_id]
        PRIMARY KEY CLUSTERED (currency_rate_id ASC)
        WITH ( DATA_COMPRESSION = NONE)
        ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'currency_rate'
                                              , N'CONSTRAINT',N'pk_currency_rate_currency_rate_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Primary key (clustered) constraint'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'currency_rate'
                                  , @level2type=N'CONSTRAINT',@level2name=N'pk_currency_rate_currency_rate_id'
GO
