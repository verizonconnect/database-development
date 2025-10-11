DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'human_resources'
                           AND tc.table_name = 'job_candidate'
                           AND tc.constraint_name = 'pk_job_candidate'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE human_resources.job_candidate
        ADD CONSTRAINT "pk_job_candidate"
        PRIMARY KEY (job_candidate_id);
    END IF;
END$$
