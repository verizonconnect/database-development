DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'human_resources'
                           AND tc.table_name = 'job_candidate'
                           AND tc.constraint_name = 'fk_job_candidate_employee_business_entity_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE human_resources.job_candidate
        ADD CONSTRAINT "fk_job_candidate_employee_business_entity_id"
        FOREIGN KEY (business_entity_id)
        REFERENCES human_resources.employee(business_entity_id);
    END IF;
END$$
