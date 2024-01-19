CREATE TABLE IF NOT EXISTS human_resources.employee_department_history(
    business_entity_id INT NOT NULL
   ,department_id SMALLINT NOT NULL
   ,shift_id SMALLINT NOT NULL
   ,start_date DATE NOT NULL
   ,end_date DATE NULL
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);
COMMENT ON TABLE human_resources.employee_department_history IS 'employee department transfers.';
COMMENT ON COLUMN human_resources.employee_department_history.business_entity_id IS 'employee identification number. foreign key to employee.business_entity_id.';
COMMENT ON COLUMN human_resources.employee_department_history.department_id IS 'department in which the employee worked including currently. foreign key to department.department_id.';
COMMENT ON COLUMN human_resources.employee_department_history.shift_id IS 'Identifies which 8-hour shift the employee works. foreign key to shift.shift.ID.';
COMMENT ON COLUMN human_resources.employee_department_history.start_date IS 'Date the employee started work in the department.';
COMMENT ON COLUMN human_resources.employee_department_history.end_date IS 'Date the employee left the department. NULL = current department.';