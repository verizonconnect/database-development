CREATE TABLE IF NOT EXISTS production.product_category(
    product_category_id INT AUTO_INCREMENT NOT NULL COMMENT 'Primary key for product_category records.'
   ,name VARCHAR(50) NOT NULL COMMENT 'Category description.'
   ,rowguid CHAR(36) NOT NULL DEFAULT (UUID())
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())

   ,CONSTRAINT `pk_product_category` PRIMARY KEY (product_category_id)
)
COMMENT 'High-level product categorization.';
