DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.check_constraints AS cc
                           INNER JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_schema = cc.constraint_schema
                               AND ccu.constraint_name = cc.constraint_name
                   WHERE   ccu.constraint_schema = 'human_resources'
                           AND ccu.table_name = 'employee'
                           AND ccu.column_name = 'sick_leave_hours'
                           AND ccu.constraint_name = 'ck_employee_sick_leave_hours')
    THEN
        ALTER TABLE human_resources.employee
        ADD CONSTRAINT ck_employee_sick_leave_hours
        CHECK (sick_leave_hours BETWEEN 0 AND 120);
    END IF;
END$$
