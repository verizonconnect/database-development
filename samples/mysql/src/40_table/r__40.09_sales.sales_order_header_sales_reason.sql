CREATE TABLE IF NOT EXISTS sales.sales_order_header_sales_reason(
    sales_order_id INT NOT NULL COMMENT 'Primary key. foreign key to sales_order_header.sales_order_id.'
   ,sales_reason_id INT NOT NULL COMMENT 'Primary key. foreign key to sales_reason.sales_reason_id.'
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())
   ,CONSTRAINT `pk_sales_order_header_sales_reason` PRIMARY KEY (sales_order_id, sales_reason_id)
)
COMMENT 'Cross-reference table mapping sales orders to sales reason codes.';
