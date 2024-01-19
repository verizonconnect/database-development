CREATE TABLE IF NOT EXISTS production.product_model_product_description_culture(
    product_model_id INT NOT NULL
   ,product_description_id INT NOT NULL
   ,culture_id char(6) NOT NULL
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);
  
COMMENT ON TABLE production.product_model_product_description_culture IS 'Cross-reference table mapping product descriptions and the language the description is written in.';
COMMENT ON COLUMN production.product_model_product_description_culture.product_model_id IS 'Primary key. foreign key to product_model.product_model_id.';
COMMENT ON COLUMN production.product_model_product_description_culture.product_description_id IS 'Primary key. foreign key to product_description.product_description_id.';
COMMENT ON COLUMN production.product_model_product_description_culture.culture_id IS 'culture identification number. foreign key to culture.culture_id.';