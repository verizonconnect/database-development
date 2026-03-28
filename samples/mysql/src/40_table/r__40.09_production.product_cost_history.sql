CREATE TABLE IF NOT EXISTS production.product_cost_history(
    product_id INT NOT NULL COMMENT 'product identification number. foreign key to product.product_id'
   ,start_date DATETIME NOT NULL COMMENT 'product cost start date.'
   ,end_date DATETIME NULL COMMENT 'product cost end date.'
   ,standard_cost DECIMAL(19,4) NOT NULL COMMENT 'Standard cost of the product.'
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())
   ,CONSTRAINT `pk_product_cost_history` PRIMARY KEY (product_id, start_date)
)
COMMENT 'Changes in the cost of a product over time.';
