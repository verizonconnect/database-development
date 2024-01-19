CREATE TABLE IF NOT EXISTS purchasing.purchase_order_detail(
    purchase_order_id INT NOT NULL
   ,purchase_order_detail_id SERIAL NOT NULL
   ,due_date TIMESTAMP NOT NULL
   ,order_qty SMALLINT NOT NULL
   ,product_id INT NOT NULL
   ,unit_price NUMERIC NOT NULL
   ,line_total NUMERIC
   ,received_qty DECIMAL(8, 2) NOT NULL
   ,rejected_qty DECIMAL(8, 2) NOT NULL
   ,stocked_qty NUMERIC
   ,modified_date TIMESTAMP NOT NULL DEFAULT (now() at time zone 'utc')
);

COMMENT ON TABLE purchasing.purchase_order_detail IS 'Individual products associated with a specific purchase order. see purchase_order_header.';
COMMENT ON COLUMN purchasing.purchase_order_detail.purchase_order_id IS 'Primary key. foreign key to purchase_order_header.purchase_order_id.';
COMMENT ON COLUMN purchasing.purchase_order_detail.purchase_order_detail_id IS 'Primary key. one line number per purchase_d product.';
COMMENT ON COLUMN purchasing.purchase_order_detail.due_date IS 'Date the product is expected to be received.';
COMMENT ON COLUMN purchasing.purchase_order_detail.order_qty IS 'quantity ordered.';
COMMENT ON COLUMN purchasing.purchase_order_detail.product_id IS 'product identification number. foreign key to product.product_id.';
COMMENT ON COLUMN purchasing.purchase_order_detail.unit_price IS 'Vendor''s selling price of a single product.';
--  COMMENT ON COLUMN purchasing.purchase_order_detail.line_total IS 'Per product subtotal. computed as order_qty * unit_price.';
COMMENT ON COLUMN purchasing.purchase_order_detail.received_qty IS 'quantity actually received from the vendor.';
COMMENT ON COLUMN purchasing.purchase_order_detail.rejected_qty IS 'quantity rejected during inspection.';