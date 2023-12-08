
IF OBJECT_ID('[sales].[fk_currency_rate_currency_to_currency_code]', 'F') IS NULL
BEGIN
    ALTER TABLE [sales].[currency_rate]  
    ADD CONSTRAINT [fk_currency_rate_currency_to_currency_code] 
    FOREIGN KEY (to_currency_code)
    REFERENCES [sales].[currency] (currency_code)
    ON DELETE NO ACTION;
END;
GO

ALTER TABLE [sales].[currency_rate] 
CHECK CONSTRAINT [fk_currency_rate_currency_to_currency_code];
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'currency_rate'
                                              , N'CONSTRAINT',N'fk_currency_rate_currency_to_currency_code'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Foreign key constraint referencing currency.to_currency_code.'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'currency_rate'
                                  , @level2type=N'CONSTRAINT',@level2name=N'fk_currency_rate_currency_to_currency_code'
GO
