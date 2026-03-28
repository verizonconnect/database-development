CREATE TABLE IF NOT EXISTS production.product_list_price_history(
    product_id INT NOT NULL COMMENT 'product identification number. foreign key to product.product_id'
   ,start_date DATETIME NOT NULL COMMENT 'List price start date.'
   ,end_date DATETIME NULL COMMENT 'List price end date'
   ,list_price DECIMAL(19,4) NOT NULL COMMENT 'product list price.'
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())
   ,CONSTRAINT `pk_product_list_price_history` PRIMARY KEY (product_id, start_date)
)
COMMENT 'Changes in the list price of a product over time.';
