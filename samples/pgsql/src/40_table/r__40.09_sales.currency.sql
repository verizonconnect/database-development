CREATE TABLE IF NOT EXISTS sales.currency(
    currency_code CHAR(3) NOT NULL
   ,name common.name NOT NULL
   ,modified_date TIMESTAMP NOT NULL DEFAULT (now() at time zone 'utc')
);
COMMENT ON TABLE sales.currency IS 'Lookup table containing standard ISO currencies.';
COMMENT ON COLUMN sales.currency.currency_code IS 'The ISO code for the currency.';
COMMENT ON COLUMN sales.currency.name IS 'Currency name.';