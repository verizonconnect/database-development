
IF OBJECT_ID('[production].[fk_document_employee_owner]', 'F') IS NULL
BEGIN
    ALTER TABLE [production].[document]  
    ADD CONSTRAINT [fk_document_employee_owner] 
    FOREIGN KEY (owner)
    REFERENCES [human_resources].[employee] (business_entity_id)
    ON DELETE NO ACTION;
END;
GO

ALTER TABLE [production].[document] 
CHECK CONSTRAINT [fk_document_employee_owner];
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'document'
                                              , N'CONSTRAINT',N'fk_document_employee_owner'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Foreign key constraint referencing employee.business_entity_id.'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'document'
                                  , @level2type=N'CONSTRAINT',@level2name=N'fk_document_employee_owner'
GO
