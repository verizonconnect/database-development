CREATE TABLE IF NOT EXISTS purchasing.purchase_order_header(
    purchase_order_id SERIAL NOT NULL
   ,revision_number SMALLINT NOT NULL DEFAULT (0)
   ,status SMALLINT NOT NULL DEFAULT (1)
   ,employee_id INT NOT NULL
   ,vendor_id INT NOT NULL
   ,ship_method_id INT NOT NULL
   ,order_date TIMESTAMP NOT NULL DEFAULT (now() at time zone 'utc')
   ,ship_date TIMESTAMP NULL
   ,sub_total NUMERIC NOT NULL DEFAULT (0.00)
   ,tax_amt NUMERIC NOT NULL DEFAULT (0.00)
   ,freight NUMERIC NOT NULL DEFAULT (0.00)
   ,total_due NUMERIC
   ,modified_date TIMESTAMP NOT NULL DEFAULT (now() at time zone 'utc')
);

COMMENT ON TABLE purchasing.purchase_order_header IS 'General purchase order information. see purchase_order_detail.';
COMMENT ON COLUMN purchasing.purchase_order_header.purchase_order_id IS 'Primary key.';
COMMENT ON COLUMN purchasing.purchase_order_header.revision_number IS 'Incremental number to track changes to the purchase order over time.';
COMMENT ON COLUMN purchasing.purchase_order_header.status IS 'Order current status. 1 = pending; 2 = approved; 3 = rejected; 4 = complete';
COMMENT ON COLUMN purchasing.purchase_order_header.employee_id IS 'employee who created the purchase order. foreign key to employee.business_entity_id.';
COMMENT ON COLUMN purchasing.purchase_order_header.vendor_id IS 'Vendor with whom the purchase order is placed. foreign key to vendor.business_entity_id.';
COMMENT ON COLUMN purchasing.purchase_order_header.ship_method_id IS 'Shipping method. foreign key to ship_method.ship_method_id.';
COMMENT ON COLUMN purchasing.purchase_order_header.order_date IS 'Purchase order creation date.';
COMMENT ON COLUMN purchasing.purchase_order_header.ship_date IS 'Estimated shipment date from the vendor.';
COMMENT ON COLUMN purchasing.purchase_order_header.sub_total IS 'Purchase order subtotal. computed as SUM(purchase_order_detail.line_total)for the appropriate purchase_order_id.';
COMMENT ON COLUMN purchasing.purchase_order_header.tax_amt IS 'Tax amount.';
COMMENT ON COLUMN purchasing.purchase_order_header.freight IS 'Shipping cost.';