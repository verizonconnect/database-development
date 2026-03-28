CREATE TABLE IF NOT EXISTS production.transaction_history(
    transaction_id INT AUTO_INCREMENT NOT NULL COMMENT 'Primary key for transaction_history records.'
   ,product_id INT NOT NULL COMMENT 'product identification number. foreign key to product.product_id.'
   ,reference_order_id INT NOT NULL COMMENT 'Purchase order, sales order, or work order identification number.'
   ,reference_order_line_id INT NOT NULL DEFAULT (0) COMMENT 'Line number associated with the purchase order, sales order, or work order.'
   ,transaction_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP()) COMMENT 'Date and time of the transaction.'
   ,transaction_type char(1) NOT NULL COMMENT 'W = work_order, S = sales_order, P = purchase_order'
   ,quantity INT NOT NULL COMMENT 'product quantity.'
   ,actual_cost DECIMAL(19,4) NOT NULL COMMENT 'product cost.'
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())

   ,CONSTRAINT `pk_transaction_history` PRIMARY KEY (transaction_id)
)
COMMENT 'Record of each purchase order, sales order, or work order transaction year to date.';
