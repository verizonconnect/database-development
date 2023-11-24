
IF OBJECT_ID('[person].[fk_business_entity_contact_contact_type_contact_type_id]', 'F') IS NULL
BEGIN
    ALTER TABLE [person].[business_entity_contact]  
    ADD CONSTRAINT [fk_business_entity_contact_contact_type_contact_type_id] 
    FOREIGN KEY (contact_type_id)
    REFERENCES [person].[contact_type] (contact_type_id)
    ON DELETE NO ACTION;
END;
GO

ALTER TABLE [person].[business_entity_contact] 
CHECK CONSTRAINT [fk_business_entity_contact_contact_type_contact_type_id];
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'person'
                                              , N'TABLE',N'business_entity_contact'
                                              , N'CONSTRAINT',N'fk_business_entity_contact_contact_type_contact_type_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Foreign key constraint referencing contact_type.contact_type_id.'
                                  , @level0type=N'SCHEMA',@level0name=N'person'
                                  , @level1type=N'TABLE',@level1name=N'business_entity_contact'
                                  , @level2type=N'CONSTRAINT',@level2name=N'fk_business_entity_contact_contact_type_contact_type_id'
GO
