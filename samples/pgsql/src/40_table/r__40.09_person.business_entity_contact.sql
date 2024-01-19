CREATE TABLE IF NOT EXISTS person.business_entity_contact(
    business_entity_id INT NOT NULL
   ,person_id INT NOT NULL
   ,contact_type_id INT NOT NULL
   ,rowguid uuid NOT NULL DEFAULT (uuid_generate_v1())
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);
COMMENT ON TABLE person.business_entity_contact IS 'Cross-reference table mapping stores, vendors, and employees to people';
COMMENT ON COLUMN person.business_entity_contact.business_entity_id IS 'Primary key. foreign key to business_entity.business_entity_id.';
COMMENT ON COLUMN person.business_entity_contact.person_id IS 'Primary key. foreign key to person.business_entity_id.';
COMMENT ON COLUMN person.business_entity_contact.contact_type_id IS 'Primary key.  foreign key to contact_type.contact_type_id.';