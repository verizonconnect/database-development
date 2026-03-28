CREATE TABLE IF NOT EXISTS sales.currency(
    currency_code CHAR(3) NOT NULL COMMENT 'The ISO code for the currency.'
   ,name VARCHAR(50) NOT NULL COMMENT 'Currency name.'
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())
   ,CONSTRAINT `pk_currency` PRIMARY KEY (currency_code)
)
COMMENT 'Lookup table containing standard ISO currencies.';
