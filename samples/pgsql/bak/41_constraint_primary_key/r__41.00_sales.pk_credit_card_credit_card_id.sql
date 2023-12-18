
IF OBJECT_ID('[sales].[pk_credit_card_credit_card_id]', 'PK') IS NULL
    BEGIN
        ALTER TABLE [sales].[credit_card]
        ADD CONSTRAINT [pk_credit_card_credit_card_id]
        PRIMARY KEY CLUSTERED (credit_card_id ASC)
        WITH ( DATA_COMPRESSION = NONE)
        ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'credit_card'
                                              , N'CONSTRAINT',N'pk_credit_card_credit_card_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Primary key (clustered) constraint'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'credit_card'
                                  , @level2type=N'CONSTRAINT',@level2name=N'pk_credit_card_credit_card_id'
GO
