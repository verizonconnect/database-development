CREATE TABLE IF NOT EXISTS production.product_description(
    product_description_id SERIAL NOT NULL
   ,description VARCHAR(400) NOT NULL
   ,rowguid uuid NOT NULL DEFAULT (uuid_generate_v1())
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);
  
COMMENT ON TABLE production.product_description IS 'product descriptions in several languages.';
COMMENT ON COLUMN production.product_description.product_description_id IS 'Primary key for product_description records.';
COMMENT ON COLUMN production.product_description.description IS 'description of the product.';