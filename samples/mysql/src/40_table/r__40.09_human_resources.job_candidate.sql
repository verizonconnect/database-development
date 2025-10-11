CREATE TABLE IF NOT EXISTS human_resources.job_candidate(
    job_candidate_id    INT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Primary key for job_candidate records.'
   ,business_entity_id  INT NULL COMMENT 'Employee identification number if applicant was hired. foreign key to employee.business_entity_id.'
   ,cv_doc              JSON NULL COMMENT 'CV in JSON format.'
   ,modified_utc_when   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Date and time the record was last updated.'
   ,created_utc_when    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Date and time the record was created.'
) COMMENT 'CVs submitted to human resources by job applicants.';
