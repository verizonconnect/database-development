CREATE TABLE IF NOT EXISTS production.product_sub_category(
    product_sub_category_id INT AUTO_INCREMENT NOT NULL COMMENT 'Primary key for product_sub_category records.'
   ,product_category_id INT NOT NULL COMMENT 'product category identification number. foreign key to product_category.product_category_id.'
   ,name VARCHAR(50) NOT NULL COMMENT 'Subcategory description.'
   ,rowguid CHAR(36) NOT NULL DEFAULT (UUID())
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())

   ,CONSTRAINT `pk_product_sub_category` PRIMARY KEY (product_sub_category_id)
)
COMMENT 'product subcategories. see product_category table.';
