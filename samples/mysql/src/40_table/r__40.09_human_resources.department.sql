CREATE TABLE IF NOT EXISTS human_resources.Department(
    department_id     INT            NOT NULL COMMENT 'Primary key for department records.'
    ,department_name_o VARCHAR(50)    NOT NULL COMMENT 'name of the department.'
   ,group_name        VARCHAR(50)    NOT NULL COMMENT 'name of the group to which the department belongs.'
    ,modified_utc_when TIMESTAMP      NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'audit when row value modified.'
    ,created_utc_when  TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'audit when row inserted.'
)
COMMENT 'Lookup table containing the departments within the adventure works cycles company.';
