CREATE TABLE IF NOT EXISTS production.product_description(
    product_description_id INT AUTO_INCREMENT NOT NULL COMMENT 'Primary key for product_description records.'
   ,description VARCHAR(400) NOT NULL COMMENT 'description of the product.'
   ,rowguid CHAR(36) NOT NULL DEFAULT (UUID())
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())

   ,CONSTRAINT `pk_product_description` PRIMARY KEY (product_description_id)
)
COMMENT 'product descriptions in several languages.';
