DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.check_constraints AS cc
                           INNER JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_schema = cc.constraint_schema
                               AND ccu.constraint_name = cc.constraint_name
                   WHERE   ccu.constraint_schema = 'human_resources'
                           AND ccu.table_name = 'employee_pay_history'
                           AND ccu.column_name = 'rate'
                           AND ccu.constraint_name = 'ck_employee_pay_history_rate')
    THEN
        ALTER TABLE human_resources.employee_pay_history
        ADD CONSTRAINT ck_employee_pay_history_rate
        CHECK (rate BETWEEN 6.50 AND 200.00);
    END IF;
END$$
