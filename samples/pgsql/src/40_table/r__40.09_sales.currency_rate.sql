CREATE TABLE IF NOT EXISTS sales.currency_rate(
    currency_rate_id SERIAL NOT NULL
   ,currency_rate_date TIMESTAMP NOT NULL
   ,from_currency_code char(3) NOT NULL
   ,to_currency_code char(3) NOT NULL
   ,average_rate NUMERIC NOT NULL
   ,end_of_day_rate NUMERIC NOT NULL
   ,modified_date TIMESTAMP NOT NULL DEFAULT (now() at time zone 'utc')
);
COMMENT ON TABLE sales.currency_rate IS 'Currency exchange _rates.';
COMMENT ON COLUMN sales.currency_rate.currency_rate_id IS 'Primary key for currency_rate records.';
COMMENT ON COLUMN sales.currency_rate.currency_rate_date IS 'Date and time the exchange _rate was obtained.';
COMMENT ON COLUMN sales.currency_rate.from_currency_code IS 'Exchange _rate was converted from this currency code.';
COMMENT ON COLUMN sales.currency_rate.to_currency_code IS 'Exchange _rate was converted to this currency code.';
COMMENT ON COLUMN sales.currency_rate.average_rate IS 'Average exchange _rate for the day.';
COMMENT ON COLUMN sales.currency_rate.end_of_day_rate IS 'Final exchange _rate for the day.';