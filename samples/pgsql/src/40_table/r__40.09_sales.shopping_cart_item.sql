CREATE TABLE IF NOT EXISTS sales.shopping_cart_item(
    shopping_cart_item_id SERIAL NOT NULL
   ,shopping_cart_id varchar(50) NOT NULL
   ,quantity INT NOT NULL DEFAULT (1)
   ,product_id INT NOT NULL
   ,date_created TIMESTAMP NOT NULL DEFAULT (now() at time zone 'utc')
   ,modified_date TIMESTAMP NOT NULL DEFAULT (now() at time zone 'utc')
);
COMMENT ON TABLE sales.shopping_cart_item IS 'Contains online customer orders until the order is submitted or cancelled.';
COMMENT ON COLUMN sales.shopping_cart_item.shopping_cart_item_id IS 'Primary key for shopping_cart_item records.';
COMMENT ON COLUMN sales.shopping_cart_item.shopping_cart_id IS 'Shopping cart identification number.';
COMMENT ON COLUMN sales.shopping_cart_item.quantity IS 'product quantity ordered.';
COMMENT ON COLUMN sales.shopping_cart_item.product_id IS 'product ordered. foreign key to product.product_id.';
COMMENT ON COLUMN sales.shopping_cart_item.date_created IS 'Date the time the record was created.';