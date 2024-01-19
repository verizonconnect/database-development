CREATE TABLE IF NOT EXISTS person.email_address(
    business_entity_id INT NOT NULL
   ,email_address_id SERIAL
   ,email_address VARCHAR(50) NULL
   ,rowguid uuid NOT NULL DEFAULT (common.uuid_generate_v1())
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);
COMMENT ON TABLE person.email_address IS 'Where to send a person email.';
COMMENT ON COLUMN person.email_address.business_entity_id IS 'Primary key. person associated with this email address.  foreign key to person.business_entity_id';
COMMENT ON COLUMN person.email_address.email_address_id IS 'Primary key. ID of this email address.';
COMMENT ON COLUMN person.email_address.email_address IS 'E-mail address for the person.';