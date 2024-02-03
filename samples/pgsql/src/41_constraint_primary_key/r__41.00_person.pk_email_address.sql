DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'person'
                           AND tc.table_name = 'email_address'
                           AND tc.constraint_name = 'pk_email_address'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE person.email_address
        ADD CONSTRAINT "pk_email_address"
        PRIMARY KEY (business_entity_id, email_address_id);
    END IF;
END$$
