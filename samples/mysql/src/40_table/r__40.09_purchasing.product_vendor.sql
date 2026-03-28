CREATE TABLE IF NOT EXISTS purchasing.product_vendor(
    product_id INT NOT NULL COMMENT 'Primary key. foreign key to product.product_id.'
   ,business_entity_id INT NOT NULL COMMENT 'Primary key. foreign key to vendor.business_entity_id.'
   ,average_lead_time INT NOT NULL COMMENT 'The average span of time (in days) between placing an order with the vendor and receiving the purchase_d product.'
   ,standard_price DECIMAL(19,4) NOT NULL COMMENT 'The vendor\'s usual selling price.'
   ,last_receipt_cost DECIMAL(19,4) NULL COMMENT 'The selling price when last purchase_d.'
   ,last_receipt_date DATETIME NULL COMMENT 'Date the product was last received by the vendor.'
   ,min_order_qty INT NOT NULL COMMENT 'The maximum quantity that should be ordered.'
   ,max_order_qty INT NOT NULL COMMENT 'The minimum quantity that should be ordered.'
   ,on_order_qty INT NULL COMMENT 'The quantity currently on order.'
   ,unit_measure_code char(3) NOT NULL COMMENT 'The product\'s unit of measure.'
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())
   ,CONSTRAINT `pk_product_vendor` PRIMARY KEY (product_id, business_entity_id)
)
COMMENT 'Cross-reference table mapping vendors with the products they supply.';
