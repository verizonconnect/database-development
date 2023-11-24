
IF OBJECT_ID('[person].[fk_business_entity_address_address_address_id]', 'F') IS NULL
BEGIN
    ALTER TABLE [person].[business_entity_address]  
    ADD CONSTRAINT [fk_business_entity_address_address_address_id] 
    FOREIGN KEY (address_id)
    REFERENCES [person].[address] (address_id)
    ON DELETE NO ACTION;
END;
GO

ALTER TABLE [person].[business_entity_address] 
CHECK CONSTRAINT [fk_business_entity_address_address_address_id];
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'person'
                                              , N'TABLE',N'business_entity_address'
                                              , N'CONSTRAINT',N'fk_business_entity_address_address_address_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Foreign key constraint referencing address.address_id.'
                                  , @level0type=N'SCHEMA',@level0name=N'person'
                                  , @level1type=N'TABLE',@level1name=N'business_entity_address'
                                  , @level2type=N'CONSTRAINT',@level2name=N'fk_business_entity_address_address_address_id'
GO
