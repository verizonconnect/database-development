CREATE TABLE IF NOT EXISTS person.country_region(
    country_region_code VARCHAR(3) NOT NULL COMMENT 'ISO standard code for countries and regions.'
   ,name VARCHAR(50) NOT NULL COMMENT 'Country or region name.'
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())
   ,CONSTRAINT `pk_country_region` PRIMARY KEY (country_region_code)
)
COMMENT 'Lookup table containing the ISO standard codes for countries and regions.';
