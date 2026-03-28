CREATE TABLE IF NOT EXISTS production.product_model(
    product_model_id INT AUTO_INCREMENT NOT NULL COMMENT 'Primary key for product_model records.'
   ,name VARCHAR(50) NOT NULL COMMENT 'product model description.'
   ,catalog_description TEXT NULL COMMENT 'Detailed product catalog information in xml format.'
   ,instructions TEXT NULL COMMENT 'Manufacturing instructions in xml format.'
   ,rowguid CHAR(36) NOT NULL DEFAULT (UUID())
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())

   ,CONSTRAINT `pk_product_model_product` PRIMARY KEY (product_model_id)
)
COMMENT 'product model classification.';
