
IF OBJECT_ID('[human_resources].[fk_employee_department_history_employee_business_entity_id]', 'F') IS NULL
BEGIN
    ALTER TABLE [human_resources].[employee_department_history]  
    ADD CONSTRAINT [fk_employee_department_history_employee_business_entity_id] 
    FOREIGN KEY (business_entity_id)
    REFERENCES [human_resources].[employee] (business_entity_id)
    ON DELETE NO ACTION;
END;
GO

ALTER TABLE [human_resources].[employee_department_history] 
CHECK CONSTRAINT [fk_employee_department_history_employee_business_entity_id];
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'human_resources'
                                              , N'TABLE',N'employee_department_history'
                                              , N'CONSTRAINT',N'fk_employee_department_history_employee_business_entity_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Foreign key constraint referencing employee.employee_id.'
                                  , @level0type=N'SCHEMA',@level0name=N'human_resources'
                                  , @level1type=N'TABLE',@level1name=N'employee_department_history'
                                  , @level2type=N'CONSTRAINT',@level2name=N'fk_employee_department_history_employee_business_entity_id'
GO
