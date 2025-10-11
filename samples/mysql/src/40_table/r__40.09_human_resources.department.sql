CREATE TABLE IF NOT EXISTS human_resources.department(
    department_id   INT            NOT NULL COMMENT 'Primary key for department records.'
   ,name            VARCHAR(50)    NOT NULL COMMENT 'name of the department.'
   ,group_name      VARCHAR(50)    NOT NULL COMMENT 'name of the group to which the department belongs.'
   ,modified_date   TIMESTAMP      NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'audit when row value modified.'
   ,created_date    TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'audit when row inserted.'
)
COMMENT 'Lookup table containing the departments within the adventure works cycles company.';
