CREATE TABLE IF NOT EXISTS production.product_model_illustration(
    product_model_id INT NOT NULL
   ,illustration_id INT NOT NULL
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);
  
COMMENT ON TABLE production.product_model_illustration IS 'Cross-reference table mapping product models and illustrations.';
COMMENT ON COLUMN production.product_model_illustration.product_model_id IS 'Primary key. foreign key to product_model.product_model_id.';
COMMENT ON COLUMN production.product_model_illustration.illustration_id IS 'Primary key. foreign key to illustration.illustration_id.';