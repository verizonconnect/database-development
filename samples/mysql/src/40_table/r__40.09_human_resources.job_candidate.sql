CREATE TABLE IF NOT EXISTS human_resources.job_candidate(
    job_candidate_id INT AUTO_INCREMENT NOT NULL COMMENT 'Primary key for job_candidate records.'
   ,business_entity_id INT NULL COMMENT 'employee identification number if applicant was hired. foreign key to employee.business_entity_id.'
   ,cv TEXT NULL COMMENT 'CV in XML format.'
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())

   ,CONSTRAINT `pk_job_candidate` PRIMARY KEY (job_candidate_id)
)
COMMENT 'CVs submitted to human resources by job applicants.';
