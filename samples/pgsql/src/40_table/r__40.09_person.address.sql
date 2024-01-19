CREATE TABLE IF NOT EXISTS person.address(
    address_id SERIAL
   ,address_line_1 VARCHAR(60) NOT NULL
   ,address_line_2 VARCHAR(60) NULL
   ,city VARCHAR(30) NOT NULL
   ,state_province_id INT NOT NULL
   ,postal_code VARCHAR(15) NOT NULL
   ,spatial_location bytea NULL
   ,rowguid uuid NOT NULL DEFAULT (common.uuid_generate_v1())
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);
COMMENT ON TABLE person.address IS 'Street address information for customers, employees, and vendors.';
COMMENT ON COLUMN person.address.address_id IS 'Primary key for address records.';
COMMENT ON COLUMN person.address.address_line_1 IS 'First street address line.';
COMMENT ON COLUMN person.address.address_line_2 IS 'Second street address line.';
COMMENT ON COLUMN person.address.city IS 'name of the city.';
COMMENT ON COLUMN person.address.state_province_id IS 'Unique identification number for the state or province. foreign key to state_province table.';
COMMENT ON COLUMN person.address.postal_code IS 'Postal code for the street address.';
COMMENT ON COLUMN person.address.spatial_location IS 'Latitude and longitude of this address.';