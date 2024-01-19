CREATE TABLE IF NOT EXISTS production.product_model(
    product_model_id SERIAL NOT NULL
   ,name common.name NOT NULL
   ,catalog_description XML NULL
   ,instructions XML NULL
   ,rowguid uuid NOT NULL DEFAULT (uuid_generate_v1())
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);
COMMENT ON TABLE production.product_model IS 'product model classification.';
COMMENT ON COLUMN production.product_model.product_model_id IS 'Primary key for product_model records.';
COMMENT ON COLUMN production.product_model.name IS 'product model description.';
COMMENT ON COLUMN production.product_model.catalog_description IS 'Detailed product catalog information in xml format.';
COMMENT ON COLUMN production.product_model.instructions IS 'Manufacturing instructions in xml format.';