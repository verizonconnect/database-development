DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'human_resources'
                           AND tc.table_name = 'employee'
                           AND tc.constraint_name = 'pk_employee'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE human_resources.employee
        ADD CONSTRAINT "pk_employee"
        PRIMARY KEY (business_entity_id);
    END IF;
END$$
