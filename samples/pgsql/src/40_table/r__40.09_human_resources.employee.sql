CREATE TABLE IF NOT EXISTS human_resources.employee(
    business_entity_id INT NOT NULL
   ,national_id_number VARCHAR(15) NOT NULL
   ,login_id VARCHAR(256) NOT NULL
   ,organization_node VARCHAR NULL DEFAULT ('/')
   ,job_title VARCHAR(50) NOT NULL
   ,birth_date DATE NOT NULL
   ,marital_status char(1) NOT NULL
   ,gender char(1) NOT NULL
   ,hire_date DATE NOT NULL
   ,salaried_flag common.flag NOT NULL DEFAULT (true)
   ,holiday_hours SMALLINT NOT NULL DEFAULT (0)
   ,sick_leave_hours SMALLINT NOT NULL DEFAULT (0)
   ,current_flag common.flag NOT NULL DEFAULT (true)
   ,rowguid uuid NOT NULL DEFAULT (uuid_generate_v1())
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);

COMMENT ON TABLE human_resources.employee IS 'employee information such as salary, department, and title.';
COMMENT ON COLUMN human_resources.employee.business_entity_id IS 'Primary key for employee records.  foreign key to business_entity.business_entity_id.';
COMMENT ON COLUMN human_resources.employee.national_id_number IS 'Unique national identification number such as a social security number.';
COMMENT ON COLUMN human_resources.employee.login_id IS 'Network login.';
COMMENT ON COLUMN human_resources.employee.organization_node IS 'Where the employee is located in corpo_rate hierarchy.';
COMMENT ON COLUMN human_resources.employee.job_title IS 'Work title such as buyer or sales representative.';
COMMENT ON COLUMN human_resources.employee.birth_date IS 'Date of birth.';
COMMENT ON COLUMN human_resources.employee.marital_status IS 'M = married, S = single';
COMMENT ON COLUMN human_resources.employee.gender IS 'M = male, F = female';
COMMENT ON COLUMN human_resources.employee.hire_date IS 'employee hired on this date.';
COMMENT ON COLUMN human_resources.employee.salaried_flag IS 'Job classification. 0 = hourly, not exempt from collective bargaining. 1 = salaried, exempt from collective bargaining.';
COMMENT ON COLUMN human_resources.employee.holiday_hours IS 'Number of available vacation hours.';
COMMENT ON COLUMN human_resources.employee.sick_leave_hours IS 'Number of available sick leave hours.';
COMMENT ON COLUMN human_resources.employee.current_flag IS '0 = inactive, 1 = active';