CREATE TABLE IF NOT EXISTS person.address_type(
    address_type_id SERIAL
   ,name common.name NOT NULL
   ,rowguid uuid NOT NULL DEFAULT (uuid_generate_v1())
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);
COMMENT ON TABLE person.address_type IS 'Types of addresses stored in the address table.';
COMMENT ON COLUMN person.address_type.address_type_id IS 'Primary key for address_type records.';
COMMENT ON COLUMN person.address_type.name IS 'address type description. for example, billing, home, or shipping.';