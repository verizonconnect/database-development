DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'person'
                           AND tc.table_name = 'contact_type'
                           AND tc.constraint_name = 'pk_contact_type'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE person.contact_type
        ADD CONSTRAINT "pk_contact_type"
        PRIMARY KEY (contact_type_id);
    END IF;
END$$
