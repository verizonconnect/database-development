CREATE TABLE IF NOT EXISTS person.contact_type(
    contact_type_id SERIAL
   ,name common.name NOT NULL
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);
COMMENT ON TABLE person.contact_type IS 'Lookup table containing the types of business entity contacts.';
COMMENT ON COLUMN person.contact_type.contact_type_id IS 'Primary key for contact_type records.';
COMMENT ON COLUMN person.contact_type.name IS 'Contact type description.';