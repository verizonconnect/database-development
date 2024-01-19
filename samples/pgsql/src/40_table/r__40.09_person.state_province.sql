CREATE TABLE IF NOT EXISTS person.state_province(
    state_province_id SERIAL
   ,state_province_code char(3) NOT NULL
   ,country_region_code VARCHAR(3) NOT NULL
   ,is_only_state_province_flag common.flag NOT NULL DEFAULT (true)
   ,name common.name NOT NULL
   ,territory_id INT NOT NULL
   ,rowguid uuid NOT NULL DEFAULT (uuid_generate_v1()) 
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);
COMMENT ON TABLE person.state_province IS 'State and province lookup table.';
COMMENT ON COLUMN person.state_province.state_province_id IS 'Primary key for state_province records.';
COMMENT ON COLUMN person.state_province.state_province_code IS 'ISO standard state or province code.';
COMMENT ON COLUMN person.state_province.country_region_code IS 'ISO standard country or region code. foreign key to country_region.country_region_code.';
COMMENT ON COLUMN person.state_province.is_only_state_province_flag IS '0 = state_province_code exists. 1 = state_province_code unavailable, using country_region_code.';
COMMENT ON COLUMN person.state_province.name IS 'State or province description.';
COMMENT ON COLUMN person.state_province.territory_id IS 'ID of the territory in which the state or province is located. foreign key to sales_territory.sales_territory_id.';