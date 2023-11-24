
IF OBJECT_ID('[human_resources].[fk_job_candidate_employee_business_entity_id]', 'F') IS NULL
BEGIN
    ALTER TABLE [human_resources].[job_candidate]  
    ADD CONSTRAINT [fk_job_candidate_employee_business_entity_id] 
    FOREIGN KEY (business_entity_id)
    REFERENCES [human_resources].[employee] (business_entity_id)
    ON DELETE NO ACTION;
END;
GO

ALTER TABLE [human_resources].[job_candidate] 
CHECK CONSTRAINT [fk_job_candidate_employee_business_entity_id];
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'human_resources'
                                              , N'TABLE',N'job_candidate'
                                              , N'CONSTRAINT',N'fk_job_candidate_employee_business_entity_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Foreign key constraint referencing employee.employee_id.'
                                  , @level0type=N'SCHEMA',@level0name=N'human_resources'
                                  , @level1type=N'TABLE',@level1name=N'job_candidate'
                                  , @level2type=N'CONSTRAINT',@level2name=N'fk_job_candidate_employee_business_entity_id'
GO
