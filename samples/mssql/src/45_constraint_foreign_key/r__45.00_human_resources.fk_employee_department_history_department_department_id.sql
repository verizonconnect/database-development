
IF OBJECT_ID('[human_resources].[fk_employee_department_history_department_department_id]', 'F') IS NULL
BEGIN
    ALTER TABLE [human_resources].[employee_department_history]  
    ADD CONSTRAINT [fk_employee_department_history_department_department_id] 
    FOREIGN KEY (department_id)
    REFERENCES [human_resources].[department] (department_id)
    ON DELETE NO ACTION;
END;
GO

ALTER TABLE [human_resources].[employee_department_history] 
CHECK CONSTRAINT [fk_employee_department_history_department_department_id];
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'human_resources'
                                              , N'TABLE',N'employee_department_history'
                                              , N'CONSTRAINT',N'fk_employee_department_history_department_department_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Foreign key constraint referencing department.department_id.'
                                  , @level0type=N'SCHEMA',@level0name=N'human_resources'
                                  , @level1type=N'TABLE',@level1name=N'employee_department_history'
                                  , @level2type=N'CONSTRAINT',@level2name=N'fk_employee_department_history_department_department_id'
GO
