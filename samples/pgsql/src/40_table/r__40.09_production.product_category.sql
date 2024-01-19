CREATE TABLE IF NOT EXISTS production.product_category(
    product_category_id SERIAL NOT NULL
   ,name common.name NOT NULL
   ,rowguid uuid NOT NULL DEFAULT (uuid_generate_v1())
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);
  
COMMENT ON TABLE production.product_category IS 'High-level product categorization.';
COMMENT ON COLUMN production.product_category.product_category_id IS 'Primary key for product_category records.';
COMMENT ON COLUMN production.product_category.name IS 'Category description.';