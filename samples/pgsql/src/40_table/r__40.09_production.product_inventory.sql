CREATE TABLE IF NOT EXISTS production.product_inventory(
    product_id INT NOT NULL
   ,location_id SMALLINT NOT NULL
   ,shelf VARCHAR(10) NOT NULL
   ,bin SMALLINT NOT NULL
   ,quantity SMALLINT NOT NULL DEFAULT (0)
   ,rowguid uuid NOT NULL DEFAULT (common.uuid_generate_v1())
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);
  
COMMENT ON TABLE production.product_inventory IS 'product inventory information.';
COMMENT ON COLUMN production.product_inventory.product_id IS 'product identification number. foreign key to product.product_id.';
COMMENT ON COLUMN production.product_inventory.location_id IS 'Inventory location identification number. foreign key to location.location_id.';
COMMENT ON COLUMN production.product_inventory.shelf IS 'Storage compartment within an inventory location.';
COMMENT ON COLUMN production.product_inventory.bin IS 'Storage container on a shelf in an inventory location.';
COMMENT ON COLUMN production.product_inventory.quantity IS 'quantity of products in the inventory location.';