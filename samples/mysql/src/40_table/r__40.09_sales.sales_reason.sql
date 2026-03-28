CREATE TABLE IF NOT EXISTS sales.sales_reason(
    sales_reason_id INT AUTO_INCREMENT NOT NULL COMMENT 'Primary key for sales_reason records.'
   ,name VARCHAR(50) NOT NULL COMMENT 'Sales reason description.'
   ,reason_type VARCHAR(50) NOT NULL COMMENT 'Category the sales reason belongs to.'
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())

   ,CONSTRAINT `pk_sales_reason` PRIMARY KEY (sales_reason_id)
)
COMMENT 'Lookup table of customer purchase reasons.';
