CREATE TABLE IF NOT EXISTS sales.sales_order_header_sales_reason(
    sales_order_id INT NOT NULL
   ,sales_reason_id INT NOT NULL
   ,modified_date TIMESTAMP NOT NULL DEFAULT (now() at time zone 'utc')
);
COMMENT ON TABLE sales.sales_order_header_sales_reason IS 'Cross-reference table mapping sales orders to sales reason codes.';
COMMENT ON COLUMN sales.sales_order_header_sales_reason.sales_order_id IS 'Primary key. foreign key to sales_order_header.sales_order_id.';
COMMENT ON COLUMN sales.sales_order_header_sales_reason.sales_reason_id IS 'Primary key. foreign key to sales_reason.sales_reason_id.';