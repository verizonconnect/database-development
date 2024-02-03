DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'person'
                           AND tc.table_name = 'password'
                           AND tc.constraint_name = 'pk_password'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE person.password
        ADD CONSTRAINT "pk_password"
        PRIMARY KEY (business_entity_id);
    END IF;
END$$
