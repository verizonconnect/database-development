CREATE TABLE IF NOT EXISTS purchasing.purchase_order_detail(
    purchase_order_id INT NOT NULL COMMENT 'Primary key. foreign key to purchase_order_header.purchase_order_id.'
   ,purchase_order_detail_id INT AUTO_INCREMENT NOT NULL COMMENT 'Primary key. one line number per purchase_d product.'
   ,due_date DATETIME NOT NULL COMMENT 'Date the product is expected to be received.'
   ,order_qty SMALLINT NOT NULL COMMENT 'quantity ordered.'
   ,product_id INT NOT NULL COMMENT 'product identification number. foreign key to product.product_id.'
   ,unit_price DECIMAL(19,4) NOT NULL COMMENT 'Vendor\'s selling price of a single product.'
   ,line_total DECIMAL(19,4) COMMENT 'Per product subtotal. computed as order_qty * unit_price.'
   ,received_qty DECIMAL(8, 2) NOT NULL COMMENT 'quantity actually received from the vendor.'
   ,rejected_qty DECIMAL(8, 2) NOT NULL COMMENT 'quantity rejected during inspection.'
   ,stocked_qty DECIMAL(19,4)
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())

   ,CONSTRAINT `pk_purchase_order_detail` PRIMARY KEY (purchase_order_detail_id)
)
COMMENT 'Individual products associated with a specific purchase order. see purchase_order_header.';
