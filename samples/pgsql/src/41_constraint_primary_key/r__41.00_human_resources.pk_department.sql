DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'human_resources'
                           AND tc.table_name = 'department'
                           AND tc.constraint_name = 'pk_department'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE human_resources.department
        ADD CONSTRAINT "pk_department"
        PRIMARY KEY (department_id);
    END IF;
END$$
