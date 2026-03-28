CREATE TABLE IF NOT EXISTS sales.shopping_cart_item(
    shopping_cart_item_id INT AUTO_INCREMENT NOT NULL COMMENT 'Primary key for shopping_cart_item records.'
   ,shopping_cart_id varchar(50) NOT NULL COMMENT 'Shopping cart identification number.'
   ,quantity INT NOT NULL DEFAULT (1) COMMENT 'product quantity ordered.'
   ,product_id INT NOT NULL COMMENT 'product ordered. foreign key to product.product_id.'
   ,date_created DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP()) COMMENT 'Date the time the record was created.'
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())

   ,CONSTRAINT `pk_shopping_cart_item` PRIMARY KEY (shopping_cart_item_id)
)
COMMENT 'Contains online customer orders until the order is submitted or cancelled.';
