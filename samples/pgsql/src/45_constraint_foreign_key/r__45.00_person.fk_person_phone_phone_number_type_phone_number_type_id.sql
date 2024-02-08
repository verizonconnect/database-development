DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'person'
                           AND tc.table_name = 'person_phone'
                           AND tc.constraint_name = 'fk_person_phone_phone_number_type_phone_number_type_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE person.person_phone
        ADD CONSTRAINT "fk_person_phone_phone_number_type_phone_number_type_id"
        FOREIGN KEY (phone_number_type_id)
        REFERENCES person.phone_number_type(phone_number_type_id);
    END IF;
END$$
