
IF OBJECT_ID('[sales].[pk_person_credit_card_business_entity_id_credit_card_id]', 'PK') IS NULL
    BEGIN
        ALTER TABLE [sales].[person_credit_card]
        ADD CONSTRAINT [pk_person_credit_card_business_entity_id_credit_card_id]
        PRIMARY KEY CLUSTERED (business_entity_id ASC, credit_card_id ASC)
        WITH ( DATA_COMPRESSION = NONE)
        ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'person_credit_card'
                                              , N'CONSTRAINT',N'pk_person_credit_card_business_entity_id_credit_card_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Primary key (clustered) constraint'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'person_credit_card'
                                  , @level2type=N'CONSTRAINT',@level2name=N'pk_person_credit_card_business_entity_id_credit_card_id'
GO
