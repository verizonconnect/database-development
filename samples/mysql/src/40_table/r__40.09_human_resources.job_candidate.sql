CREATE TABLE IF NOT EXISTS human_resources.job_candidate(
    job_candidate_id SERIAL NOT NULL
   ,business_entity_id INT NULL
   ,cv XML NULL
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);

COMMENT ON TABLE human_resources.job_candidate IS 'CVs submitted to human resources by job applicants.';
COMMENT ON COLUMN human_resources.job_candidate.job_candidate_id IS 'Primary key for job_candidate records.';
COMMENT ON COLUMN human_resources.job_candidate.business_entity_id IS 'employee identification number if applicant was hired. foreign key to employee.business_entity_id.';
COMMENT ON COLUMN human_resources.job_candidate.cv IS 'CV in XML format.';