DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'human_resources'
                           AND tc.table_name = 'employee_pay_history'
                           AND tc.constraint_name = 'pk_employee_pay_history'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE human_resources.employee_pay_history
        ADD CONSTRAINT "pk_employee_pay_history"
        PRIMARY KEY (business_entity_id, rate_change_date);
    END IF;
END$$
