CREATE TABLE IF NOT EXISTS purchasing.product_vendor(
    product_id INT NOT NULL
   ,business_entity_id INT NOT NULL
   ,average_lead_time INT NOT NULL
   ,standard_price NUMERIC NOT NULL
   ,last_receipt_cost NUMERIC NULL
   ,last_receipt_date TIMESTAMP NULL
   ,min_order_qty INT NOT NULL
   ,max_order_qty INT NOT NULL
   ,on_order_qty INT NULL
   ,unit_measure_code char(3) NOT NULL
   ,modified_date TIMESTAMP NOT NULL DEFAULT (now() at time zone 'utc')
);

COMMENT ON TABLE purchasing.product_vendor IS 'Cross-reference table mapping vendors with the products they supply.';
COMMENT ON COLUMN purchasing.product_vendor.product_id IS 'Primary key. foreign key to product.product_id.';
COMMENT ON COLUMN purchasing.product_vendor.business_entity_id IS 'Primary key. foreign key to vendor.business_entity_id.';
COMMENT ON COLUMN purchasing.product_vendor.average_lead_time IS 'The average span of time (in days) between placing an order with the vendor and receiving the purchase_d product.';
COMMENT ON COLUMN purchasing.product_vendor.standard_price IS 'The vendor''s usual selling price.';
COMMENT ON COLUMN purchasing.product_vendor.last_receipt_cost IS 'The selling price when last purchase_d.';
COMMENT ON COLUMN purchasing.product_vendor.last_receipt_date IS 'Date the product was last received by the vendor.';
COMMENT ON COLUMN purchasing.product_vendor.min_order_qty IS 'The maximum quantity that should be ordered.';
COMMENT ON COLUMN purchasing.product_vendor.max_order_qty IS 'The minimum quantity that should be ordered.';
COMMENT ON COLUMN purchasing.product_vendor.on_order_qty IS 'The quantity currently on order.';
COMMENT ON COLUMN purchasing.product_vendor.unit_measure_code IS 'The product''s unit of measure.';