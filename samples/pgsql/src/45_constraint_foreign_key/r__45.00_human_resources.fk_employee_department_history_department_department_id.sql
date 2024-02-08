﻿DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'human_resources'
                           AND tc.table_name = 'employee_department_history'
                           AND tc.constraint_name = 'fk_employee_department_history_department_department_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE human_resources.employee_department_history
        ADD CONSTRAINT "fk_employee_department_history_department_department_id"
        FOREIGN KEY (department_id)
        REFERENCES human_resources.department(department_id);
    END IF;
END$$
