CREATE TABLE IF NOT EXISTS person.country_region(
    country_region_code VARCHAR(3) NOT NULL
   ,name common.name NOT NULL
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);
COMMENT ON TABLE person.country_region IS 'Lookup table containing the ISO standard codes for countries and regions.';
COMMENT ON COLUMN person.country_region.country_region_code IS 'ISO standard code for countries and regions.';
COMMENT ON COLUMN person.country_region.name IS 'Country or region name.';