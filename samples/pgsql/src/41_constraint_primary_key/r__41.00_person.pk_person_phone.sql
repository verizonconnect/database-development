﻿DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'person'
                           AND tc.table_name = 'person_phone'
                           AND tc.constraint_name = 'pk_person_phone'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE person.person_phone
        ADD CONSTRAINT "pk_person_phone"
        PRIMARY KEY (business_entity_id, phone_number, phone_number_type_id);
    END IF;
END$$
