CREATE TABLE IF NOT EXISTS production.product_model_illustration(
    product_model_id INT NOT NULL COMMENT 'Primary key. foreign key to product_model.product_model_id.'
   ,illustration_id INT NOT NULL COMMENT 'Primary key. foreign key to illustration.illustration_id.'
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())
   ,CONSTRAINT `pk_product_model_illustration` PRIMARY KEY (product_model_id, illustration_id)
)
COMMENT 'Cross-reference table mapping product models and illustrations.';
