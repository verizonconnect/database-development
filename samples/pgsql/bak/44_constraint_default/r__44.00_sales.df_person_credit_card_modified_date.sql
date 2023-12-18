
IF OBJECT_ID('[sales].[df_person_credit_card_modified_date]', 'D') IS NULL
    BEGIN
        ALTER TABLE [sales].[person_credit_card]
        ADD CONSTRAINT [df_person_credit_card_modified_date]
        DEFAULT (getdate())
        FOR [modified_date];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'person_credit_card'
                                              , N'CONSTRAINT',N'df_person_credit_card_modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Default constraint value of GETDATE()'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'person_credit_card'
                                  , @level2type=N'CONSTRAINT',@level2name=N'df_person_credit_card_modified_date'
GO
