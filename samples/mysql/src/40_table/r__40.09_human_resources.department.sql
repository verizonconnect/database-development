CREATE TABLE IF NOT EXISTS human_resources.department(
    department_id INT AUTO_INCREMENT NOT NULL COMMENT 'Primary key for department records.'
   ,name VARCHAR(50) NOT NULL COMMENT 'name of the department.'
   ,group_name VARCHAR(50) NOT NULL COMMENT 'name of the group to which the department belongs.'
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())

   ,CONSTRAINT `pk_department` PRIMARY KEY (department_id)
)
COMMENT 'Lookup table containing the departments within the adventure works cycles company.';
