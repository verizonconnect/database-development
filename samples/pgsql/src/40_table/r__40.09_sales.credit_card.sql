CREATE TABLE IF NOT EXISTS sales.credit_card(
    credit_card_id SERIAL NOT NULL
   ,card_type varchar(50) NOT NULL
   ,card_number varchar(25) NOT NULL
   ,exp_month SMALLINT NOT NULL
   ,exp_year SMALLINT NOT NULL
   ,modified_date TIMESTAMP NOT NULL DEFAULT (now() at time zone 'utc')
);
COMMENT ON TABLE sales.credit_card IS 'Customer credit card information.';
COMMENT ON COLUMN sales.credit_card.credit_card_id IS 'Primary key for credit_card records.';
COMMENT ON COLUMN sales.credit_card.card_type IS 'Credit card name.';
COMMENT ON COLUMN sales.credit_card.card_number IS 'Credit card number.';
COMMENT ON COLUMN sales.credit_card.exp_month IS 'Credit card expiration month.';
COMMENT ON COLUMN sales.credit_card.exp_year IS 'Credit card expiration year.';