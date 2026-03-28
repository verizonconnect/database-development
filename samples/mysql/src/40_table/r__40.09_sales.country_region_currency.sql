CREATE TABLE IF NOT EXISTS sales.country_region_currency(
    country_region_code CHAR(3) NOT NULL COMMENT 'ISO code for countries and regions. foreign key to country_region.country_region_code.'
   ,currency_code CHAR(3) NOT NULL COMMENT 'ISO standard currency code. foreign key to currency.currency_code.'
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())
   ,CONSTRAINT `pk_country_region_currency` PRIMARY KEY (country_region_code, currency_code)
)
COMMENT 'Cross-reference table mapping ISO currency codes to a country or region.';
