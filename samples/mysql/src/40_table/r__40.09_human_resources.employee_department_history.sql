CREATE TABLE IF NOT EXISTS human_resources.employee_department_history(
    business_entity_id INT NOT NULL
        COMMENT 'Employee identification number. foreign key to employee.business_entity_id.'
   ,department_id      SMALLINT NOT NULL
        COMMENT 'Department in which the employee worked including currently. foreign key to department.department_id.'
   ,shift_id           SMALLINT NOT NULL
        COMMENT 'Identifies which 8-hour shift the employee works. foreign key to shift.shift.ID.'
   ,start_date         DATE NOT NULL
        COMMENT 'Date the employee started work in the department.',
   ,end_date           DATE NULL 
        COMMENT 'Date the employee left the department. NULL = current department.'
   ,modified_utc_when  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP 
        COMMENT 'Date and time the record was last updated.'
   ,created_utc_when   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        COMMENT 'Date and time the record was created.'
) COMMENT 'Employee department transfers.';
