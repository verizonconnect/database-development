CREATE TABLE IF NOT EXISTS sales.country_region_currency(
    country_region_code CHAR(3) NOT NULL
   ,currency_code CHAR(3) NOT NULL
   ,modified_date TIMESTAMP NOT NULL DEFAULT (now() at time zone 'utc')
);
COMMENT ON TABLE sales.country_region_currency IS 'Cross-reference table mapping ISO currency codes to a country or region.';
COMMENT ON COLUMN sales.country_region_currency.country_region_code IS 'ISO code for countries and regions. foreign key to country_region.country_region_code.';
COMMENT ON COLUMN sales.country_region_currency.currency_code IS 'ISO standard currency code. foreign key to currency.currency_code.';