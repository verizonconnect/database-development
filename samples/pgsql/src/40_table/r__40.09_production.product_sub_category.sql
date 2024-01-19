CREATE TABLE IF NOT EXISTS production.product_sub_category(
    product_sub_category_id SERIAL NOT NULL
   ,product_category_id INT NOT NULL
   ,name common.name NOT NULL
   ,rowguid uuid NOT NULL DEFAULT (common.uuid_generate_v1())
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);
  
COMMENT ON TABLE production.product_sub_category IS 'product subcategories. see product_category table.';
COMMENT ON COLUMN production.product_sub_category.product_sub_category_id IS 'Primary key for product_sub_category records.';
COMMENT ON COLUMN production.product_sub_category.product_category_id IS 'product category identification number. foreign key to product_category.product_category_id.';
COMMENT ON COLUMN production.product_sub_category.name IS 'Subcategory description.';