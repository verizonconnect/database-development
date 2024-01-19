CREATE TABLE IF NOT EXISTS production.product_list_price_history(
    product_id INT NOT NULL
   ,start_date TIMESTAMP NOT NULL
   ,end_date TIMESTAMP NULL
   ,list_price NUMERIC NOT NULL
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);
  
COMMENT ON TABLE production.product_list_price_history IS 'Changes in the list price of a product over time.';
COMMENT ON COLUMN production.product_list_price_history.product_id IS 'product identification number. foreign key to product.product_id';
COMMENT ON COLUMN production.product_list_price_history.start_date IS 'List price start date.';
COMMENT ON COLUMN production.product_list_price_history.end_date IS 'List price end date';
COMMENT ON COLUMN production.product_list_price_history.list_price IS 'product list price.';