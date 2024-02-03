DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'person'
                           AND tc.table_name = 'phone_number_type'
                           AND tc.constraint_name = 'pk_phone_number_type'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE person.phone_number_type
        ADD CONSTRAINT "pk_phone_number_type"
        PRIMARY KEY (phone_number_type_id);
    END IF;
END$$
