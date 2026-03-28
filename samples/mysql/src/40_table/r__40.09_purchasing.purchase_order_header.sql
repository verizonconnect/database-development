CREATE TABLE IF NOT EXISTS purchasing.purchase_order_header(
    purchase_order_id INT AUTO_INCREMENT NOT NULL COMMENT 'Primary key.'
   ,revision_number SMALLINT NOT NULL DEFAULT (0) COMMENT 'Incremental number to track changes to the purchase order over time.'
   ,status SMALLINT NOT NULL DEFAULT (1) COMMENT 'Order current status. 1 = pending; 2 = approved; 3 = rejected; 4 = complete'
   ,employee_id INT NOT NULL COMMENT 'employee who created the purchase order. foreign key to employee.business_entity_id.'
   ,vendor_id INT NOT NULL COMMENT 'Vendor with whom the purchase order is placed. foreign key to vendor.business_entity_id.'
   ,ship_method_id INT NOT NULL COMMENT 'Shipping method. foreign key to ship_method.ship_method_id.'
   ,order_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP()) COMMENT 'Purchase order creation date.'
   ,ship_date DATETIME NULL COMMENT 'Estimated shipment date from the vendor.'
   ,sub_total DECIMAL(19,4) NOT NULL DEFAULT (0.00) COMMENT 'Purchase order subtotal. computed as SUM(purchase_order_detail.line_total)for the appropriate purchase_order_id.'
   ,tax_amt DECIMAL(19,4) NOT NULL DEFAULT (0.00) COMMENT 'Tax amount.'
   ,freight DECIMAL(19,4) NOT NULL DEFAULT (0.00) COMMENT 'Shipping cost.'
   ,total_due DECIMAL(19,4)
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())

   ,CONSTRAINT `pk_purchase_order_header` PRIMARY KEY (purchase_order_id)
)
COMMENT 'General purchase order information. see purchase_order_detail.';
