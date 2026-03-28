CREATE TABLE IF NOT EXISTS production.transaction_history_archive(
    transaction_id INT NOT NULL COMMENT 'Primary key for transaction_history_archive records.'
   ,product_id INT NOT NULL COMMENT 'product identification number. foreign key to product.product_id.'
   ,reference_order_id INT NOT NULL COMMENT 'Purchase order, sales order, or work order identification number.'
   ,reference_order_line_id INT NOT NULL DEFAULT (0) COMMENT 'Line number associated with the purchase order, sales order, or work order.'
   ,transaction_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP()) COMMENT 'Date and time of the transaction.'
   ,transaction_type char(1) NOT NULL COMMENT 'W = work order, S = sales order, P = purchase order'
   ,quantity INT NOT NULL COMMENT 'product quantity.'
   ,actual_cost DECIMAL(19,4) NOT NULL COMMENT 'product cost.'
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())
   ,CONSTRAINT `pk_transaction_history_archive` PRIMARY KEY (transaction_id)
)
COMMENT 'Transactions for previous years.';
