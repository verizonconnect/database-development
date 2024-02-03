DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.check_constraints AS cc
                           INNER JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_schema = cc.constraint_schema
                               AND ccu.constraint_name = cc.constraint_name
                   WHERE   ccu.constraint_schema = 'human_resources'
                           AND ccu.table_name = 'employee'
                           AND ccu.column_name = 'gender'
                           AND ccu.constraint_name = 'ck_employee_gender')
    THEN
        ALTER TABLE human_resources.employee
        ADD CONSTRAINT ck_employee_gender
        CHECK (UPPER(gender) IN ('M', 'F')); -- male or female;
    END IF;
END$$
