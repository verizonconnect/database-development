CREATE TABLE IF NOT EXISTS sales.sales_order_detail(
    sales_order_id INT NOT NULL
   ,sales_order_detail_id SERIAL NOT NULL
   ,carrier_tracking_number varchar(25) NULL
   ,order_qty SMALLINT NOT NULL
   ,product_id INT NOT NULL
   ,special_offer_id INT NOT NULL
   ,unit_price NUMERIC NOT NULL
   ,unit_price_discount NUMERIC NOT NULL DEFAULT (0.0)
   ,line_total NUMERIC
   ,rowguid uuid NOT NULL DEFAULT (uuid_generate_v1())
   ,modified_date TIMESTAMP NOT NULL DEFAULT (now() at time zone 'utc')
);
COMMENT ON TABLE sales.sales_order_detail IS 'Individual products associated with a specific sales order. see sales_order_header.';
COMMENT ON COLUMN sales.sales_order_detail.sales_order_id IS 'Primary key. foreign key to sales_order_header.sales_order_id.';
COMMENT ON COLUMN sales.sales_order_detail.sales_order_detail_id IS 'Primary key. one incremental unique number per product sold.';
COMMENT ON COLUMN sales.sales_order_detail.carrier_tracking_number IS 'Shipment tracking number supplied by the shipper.';
COMMENT ON COLUMN sales.sales_order_detail.order_qty IS 'quantity ordered per product.';
COMMENT ON COLUMN sales.sales_order_detail.product_id IS 'product sold to customer. foreign key to product.product_id.';
COMMENT ON COLUMN sales.sales_order_detail.special_offer_id IS 'Promotional code. foreign key to special_offer.special_offer_id.';
COMMENT ON COLUMN sales.sales_order_detail.unit_price IS 'Selling price of a single product.';
COMMENT ON COLUMN sales.sales_order_detail.unit_price_discount IS 'Discount amount.';