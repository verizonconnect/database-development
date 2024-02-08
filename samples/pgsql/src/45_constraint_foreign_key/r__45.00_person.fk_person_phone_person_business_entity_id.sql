﻿DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'person'
                           AND tc.table_name = 'person_phone'
                           AND tc.constraint_name = 'fk_person_phone_person_business_entity_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE person.person_phone
        ADD CONSTRAINT "fk_person_phone_person_business_entity_id"
        FOREIGN KEY (business_entity_id)
        REFERENCES person.person(business_entity_id);
    END IF;
END$$
