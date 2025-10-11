DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'human_resources'
                           AND tc.table_name = 'employee_department_history'
                           AND tc.constraint_name = 'fk_employee_department_history_employee_business_entity_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE human_resources.employee_department_history
        ADD CONSTRAINT "fk_employee_department_history_employee_business_entity_id"
        FOREIGN KEY (business_entity_id)
        REFERENCES human_resources.employee(business_entity_id);
    END IF;
END$$
