CREATE TABLE IF NOT EXISTS human_resources.employee(
    business_entity_id INT NOT NULL COMMENT 'Primary key for employee records.  foreign key to business_entity.business_entity_id.'
   ,national_id_number VARCHAR(15) NOT NULL COMMENT 'Unique national identification number such as a social security number.'
   ,login_id VARCHAR(256) NOT NULL COMMENT 'Network login.'
   ,organization_node VARCHAR(255) NULL DEFAULT ('/') COMMENT 'Where the employee is located in corpo_rate hierarchy.'
   ,job_title VARCHAR(50) NOT NULL COMMENT 'Work title such as buyer or sales representative.'
   ,birth_date DATE NOT NULL COMMENT 'Date of birth.'
   ,marital_status char(1) NOT NULL COMMENT 'M = married, S = single'
   ,gender char(1) NOT NULL COMMENT 'M = male, F = female'
   ,hire_date DATE NOT NULL COMMENT 'employee hired on this date.'
   ,salaried_flag BOOLEAN NOT NULL DEFAULT (true) COMMENT 'Job classification. 0 = hourly, not exempt from collective bargaining. 1 = salaried, exempt from collective bargaining.'
   ,holiday_hours SMALLINT NOT NULL DEFAULT (0) COMMENT 'Number of available vacation hours.'
   ,sick_leave_hours SMALLINT NOT NULL DEFAULT (0) COMMENT 'Number of available sick leave hours.'
   ,current_flag BOOLEAN NOT NULL DEFAULT (true) COMMENT '0 = inactive, 1 = active'
   ,rowguid CHAR(36) NOT NULL DEFAULT (UUID())
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())
   ,CONSTRAINT `pk_employee` PRIMARY KEY (business_entity_id)
)
COMMENT 'employee information such as salary, department, and title.';
