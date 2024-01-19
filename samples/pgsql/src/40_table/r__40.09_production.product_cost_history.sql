CREATE TABLE IF NOT EXISTS production.product_cost_history(
    product_id INT NOT NULL
   ,start_date TIMESTAMP NOT NULL
   ,end_date TIMESTAMP NULL
   ,standard_cost NUMERIC NOT NULL
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);
  
COMMENT ON TABLE production.product_cost_history IS 'Changes in the cost of a product over time.';
COMMENT ON COLUMN production.product_cost_history.product_id IS 'product identification number. foreign key to product.product_id';
COMMENT ON COLUMN production.product_cost_history.start_date IS 'product cost start date.';
COMMENT ON COLUMN production.product_cost_history.end_date IS 'product cost end date.';
COMMENT ON COLUMN production.product_cost_history.standard_cost IS 'Standard cost of the product.';