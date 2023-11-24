
IF OBJECT_ID('[sales].[fk_sales_person_quota_history_sales_person_business_entity_id]', 'F') IS NULL
BEGIN
    ALTER TABLE [sales].[sales_person_quota_history]  
    ADD CONSTRAINT [fk_sales_person_quota_history_sales_person_business_entity_id] 
    FOREIGN KEY (business_entity_id)
    REFERENCES [sales].[sales_person] (business_entity_id)
    ON DELETE NO ACTION;
END;
GO

ALTER TABLE [sales].[sales_person_quota_history] 
CHECK CONSTRAINT [fk_sales_person_quota_history_sales_person_business_entity_id];
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'sales_person_quota_history'
                                              , N'CONSTRAINT',N'fk_sales_person_quota_history_sales_person_business_entity_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Foreign key constraint referencing sales_person.sales_person_id.'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'sales_person_quota_history'
                                  , @level2type=N'CONSTRAINT',@level2name=N'fk_sales_person_quota_history_sales_person_business_entity_id'
GO
