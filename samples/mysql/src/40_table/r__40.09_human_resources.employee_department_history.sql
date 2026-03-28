CREATE TABLE IF NOT EXISTS human_resources.employee_department_history(
    business_entity_id INT NOT NULL COMMENT 'employee identification number. foreign key to employee.business_entity_id.'
   ,department_id SMALLINT NOT NULL COMMENT 'department in which the employee worked including currently. foreign key to department.department_id.'
   ,shift_id SMALLINT NOT NULL COMMENT 'Identifies which 8-hour shift the employee works. foreign key to shift.shift.ID.'
   ,start_date DATE NOT NULL COMMENT 'Date the employee started work in the department.'
   ,end_date DATE NULL COMMENT 'Date the employee left the department. NULL = current department.'
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())
   ,CONSTRAINT `pk_employee_department_history` PRIMARY KEY (business_entity_id, start_date, department_id, shift_id)
)
COMMENT 'employee department transfers.';
