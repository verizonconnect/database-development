DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'person'
                           AND tc.table_name = 'address'
                           AND tc.constraint_name = 'pk_address'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE person.address
        ADD CONSTRAINT "pk_address"
        PRIMARY KEY (address_id);
    END IF;
END$$
