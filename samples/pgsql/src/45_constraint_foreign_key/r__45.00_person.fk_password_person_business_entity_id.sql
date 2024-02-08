﻿DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'person'
                           AND tc.table_name = 'password'
                           AND tc.constraint_name = 'fk_password_person_business_entity_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE person.password
        ADD CONSTRAINT "fk_password_person_business_entity_id"
        FOREIGN KEY (business_entity_id)
        REFERENCES person.person(business_entity_id);
    END IF;
END$$
