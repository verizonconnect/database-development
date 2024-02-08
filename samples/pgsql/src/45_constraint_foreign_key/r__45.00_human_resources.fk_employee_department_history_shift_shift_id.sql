DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'human_resources'
                           AND tc.table_name = 'employee_department_history'
                           AND tc.constraint_name = 'fk_employee_department_history_shift_shift_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE human_resources.employee_department_history
        ADD CONSTRAINT "fk_employee_department_history_shift_shift_id"
        FOREIGN KEY (shift_id)
        REFERENCES human_resources.shift(shift_id);
    END IF;
END$$
