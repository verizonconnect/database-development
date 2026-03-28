CREATE TABLE IF NOT EXISTS sales.currency_rate(
    currency_rate_id INT AUTO_INCREMENT NOT NULL COMMENT 'Primary key for currency_rate records.'
   ,currency_rate_date DATETIME NOT NULL COMMENT 'Date and time the exchange _rate was obtained.'
   ,from_currency_code char(3) NOT NULL COMMENT 'Exchange _rate was converted from this currency code.'
   ,to_currency_code char(3) NOT NULL COMMENT 'Exchange _rate was converted to this currency code.'
   ,average_rate DECIMAL(19,4) NOT NULL COMMENT 'Average exchange _rate for the day.'
   ,end_of_day_rate DECIMAL(19,4) NOT NULL COMMENT 'Final exchange _rate for the day.'
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())

   ,CONSTRAINT `pk_currency_rate` PRIMARY KEY (currency_rate_id)
)
COMMENT 'Currency exchange _rates.';
