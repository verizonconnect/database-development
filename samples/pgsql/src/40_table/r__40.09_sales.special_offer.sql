CREATE TABLE IF NOT EXISTS sales.special_offer(
    special_offer_id SERIAL NOT NULL
   ,description varchar(255) NOT NULL
   ,discount_pct NUMERIC NOT NULL DEFAULT (0.00)
   ,type varchar(50) NOT NULL
   ,category varchar(50) NOT NULL
   ,start_date TIMESTAMP NOT NULL
   ,end_date TIMESTAMP NOT NULL
   ,min_qty INT NOT NULL DEFAULT (0)
   ,max_qty INT NULL
   ,rowguid uuid NOT NULL DEFAULT (uuid_generate_v1())
   ,modified_date TIMESTAMP NOT NULL DEFAULT (now() at time zone 'utc')
);
COMMENT ON TABLE sales.special_offer IS 'Sale discounts lookup table.';
COMMENT ON COLUMN sales.special_offer.special_offer_id IS 'Primary key for special_offer records.';
COMMENT ON COLUMN sales.special_offer.description IS 'Discount description.';
COMMENT ON COLUMN sales.special_offer.discount_pct IS 'Discount precentage.';
COMMENT ON COLUMN sales.special_offer.type IS 'Discount type category.';
COMMENT ON COLUMN sales.special_offer.category IS 'Group the discount applies to such as reseller or customer.';
COMMENT ON COLUMN sales.special_offer.start_date IS 'Discount start date.';
COMMENT ON COLUMN sales.special_offer.end_date IS 'Discount end date.';
COMMENT ON COLUMN sales.special_offer.min_qty IS 'Minimum discount percent allowed.';
COMMENT ON COLUMN sales.special_offer.max_qty IS 'Maximum discount percent allowed.';