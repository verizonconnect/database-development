
IF OBJECT_ID('[sales].[fk_person_credit_card_person_business_entity_id]', 'F') IS NULL
BEGIN
    ALTER TABLE [sales].[person_credit_card]  
    ADD CONSTRAINT [fk_person_credit_card_person_business_entity_id] 
    FOREIGN KEY (business_entity_id)
    REFERENCES [person].[person] (business_entity_id)
    ON DELETE NO ACTION;
END;
GO

ALTER TABLE [sales].[person_credit_card] 
CHECK CONSTRAINT [fk_person_credit_card_person_business_entity_id];
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'person_credit_card'
                                              , N'CONSTRAINT',N'fk_person_credit_card_person_business_entity_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Foreign key constraint referencing person.business_entity_id.'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'person_credit_card'
                                  , @level2type=N'CONSTRAINT',@level2name=N'fk_person_credit_card_person_business_entity_id'
GO
