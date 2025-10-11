DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.check_constraints AS cc
                           INNER JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_schema = cc.constraint_schema
                               AND ccu.constraint_name = cc.constraint_name
                   WHERE   ccu.constraint_schema = 'human_resources'
                           AND ccu.table_name = 'employee_pay_history'
                           AND ccu.column_name = 'pay_frequency'
                           AND ccu.constraint_name = 'ck_employee_pay_history_pay_frequency')
    THEN
        ALTER TABLE human_resources.employee_pay_history
        ADD CONSTRAINT ck_employee_pay_history_pay_frequency
        CHECK (pay_frequency IN (1, 2)); -- 1 = monthly salary 2 = biweekly salary;
    END IF;
END$$
