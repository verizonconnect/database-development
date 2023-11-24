
IF OBJECT_ID('[sales].[fk_store_business_entity_business_entity_id]', 'F') IS NULL
BEGIN
    ALTER TABLE [sales].[store]  
    ADD CONSTRAINT [fk_store_business_entity_business_entity_id] 
    FOREIGN KEY (business_entity_id)
    REFERENCES [person].[business_entity] (business_entity_id)
    ON DELETE NO ACTION;
END;
GO

ALTER TABLE [sales].[store] 
CHECK CONSTRAINT [fk_store_business_entity_business_entity_id];
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'store'
                                              , N'CONSTRAINT',N'fk_store_business_entity_business_entity_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Foreign key constraint referencing business_entity.business_entity_id'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'store'
                                  , @level2type=N'CONSTRAINT',@level2name=N'fk_store_business_entity_business_entity_id'
GO
