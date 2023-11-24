
IF OBJECT_ID('[purchasing].[fk_vendor_business_entity_business_entity_id]', 'F') IS NULL
BEGIN
    ALTER TABLE [purchasing].[vendor]  
    ADD CONSTRAINT [fk_vendor_business_entity_business_entity_id] 
    FOREIGN KEY (business_entity_id)
    REFERENCES [person].[business_entity] (business_entity_id)
    ON DELETE NO ACTION;
END;
GO

ALTER TABLE [purchasing].[vendor] 
CHECK CONSTRAINT [fk_vendor_business_entity_business_entity_id];
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'purchasing'
                                              , N'TABLE',N'vendor'
                                              , N'CONSTRAINT',N'fk_vendor_business_entity_business_entity_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Foreign key constraint referencing business_entity.business_entity_id'
                                  , @level0type=N'SCHEMA',@level0name=N'purchasing'
                                  , @level1type=N'TABLE',@level1name=N'vendor'
                                  , @level2type=N'CONSTRAINT',@level2name=N'fk_vendor_business_entity_business_entity_id'
GO
