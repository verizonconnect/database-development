CREATE TABLE IF NOT EXISTS production.product_model_product_description_culture(
    product_model_id INT NOT NULL COMMENT 'Primary key. foreign key to product_model.product_model_id.'
   ,product_description_id INT NOT NULL COMMENT 'Primary key. foreign key to product_description.product_description_id.'
   ,culture_id char(6) NOT NULL COMMENT 'culture identification number. foreign key to culture.culture_id.'
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())
   ,CONSTRAINT `pk_product_model_product_description_culture` PRIMARY KEY (product_model_id, product_description_id, culture_id)
)
COMMENT 'Cross-reference table mapping product descriptions and the language the description is written in.';
