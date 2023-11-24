
IF OBJECT_ID('[person].[fk_password_person_business_entity_id]', 'F') IS NULL
BEGIN
    ALTER TABLE [person].[password]  
    ADD CONSTRAINT [fk_password_person_business_entity_id] 
    FOREIGN KEY (business_entity_id)
    REFERENCES [person].[person] (business_entity_id)
    ON DELETE NO ACTION;
END;
GO

ALTER TABLE [person].[password] 
CHECK CONSTRAINT [fk_password_person_business_entity_id];
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'person'
                                              , N'TABLE',N'password'
                                              , N'CONSTRAINT',N'fk_password_person_business_entity_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Foreign key constraint referencing person.business_entity_id.'
                                  , @level0type=N'SCHEMA',@level0name=N'person'
                                  , @level1type=N'TABLE',@level1name=N'password'
                                  , @level2type=N'CONSTRAINT',@level2name=N'fk_password_person_business_entity_id'
GO
