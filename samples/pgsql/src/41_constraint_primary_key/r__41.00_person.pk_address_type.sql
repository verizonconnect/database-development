DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'person'
                           AND tc.table_name = 'address_type'
                           AND tc.constraint_name = 'pk_address_type'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE person.address_type
        ADD CONSTRAINT "pk_address_type"
        PRIMARY KEY (address_type_id);
    END IF;
END$$
