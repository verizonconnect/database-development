CREATE TABLE IF NOT EXISTS person.phone_number_type(
    phone_number_type_id SERIAL
   ,name common.name NOT NULL
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);
COMMENT ON TABLE person.phone_number_type IS 'Type of phone number of a person.';
COMMENT ON COLUMN person.phone_number_type.phone_number_type_id IS 'Primary key for telephone number type records.';
COMMENT ON COLUMN person.phone_number_type.name IS 'name of the telephone number type';