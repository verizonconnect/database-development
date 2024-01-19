CREATE TABLE IF NOT EXISTS person.person_phone(
    business_entity_id INT NOT NULL
   ,phone_number common.phone NOT NULL
   ,phone_number_type_id INT NOT NULL
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);
COMMENT ON TABLE person.person_phone IS 'Telephone number and type of a person.';
COMMENT ON COLUMN person.person_phone.business_entity_id IS 'Business entity identification number. foreign key to person.business_entity_id.';
COMMENT ON COLUMN person.person_phone.phone_number IS 'Telephone number identification number.';
COMMENT ON COLUMN person.person_phone.phone_number_type_id IS 'Kind of phone number. foreign key to phone_number_type.phone_number_type_id.';