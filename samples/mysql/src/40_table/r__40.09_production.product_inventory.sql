CREATE TABLE IF NOT EXISTS production.product_inventory(
    product_id INT NOT NULL COMMENT 'product identification number. foreign key to product.product_id.'
   ,location_id SMALLINT NOT NULL COMMENT 'Inventory location identification number. foreign key to location.location_id.'
   ,shelf VARCHAR(10) NOT NULL COMMENT 'Storage compartment within an inventory location.'
   ,bin SMALLINT NOT NULL COMMENT 'Storage container on a shelf in an inventory location.'
   ,quantity SMALLINT NOT NULL DEFAULT (0) COMMENT 'quantity of products in the inventory location.'
   ,rowguid CHAR(36) NOT NULL DEFAULT (UUID())
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())
   ,CONSTRAINT `pk_product_inventory` PRIMARY KEY (product_id, location_id)
)
COMMENT 'product inventory information.';
