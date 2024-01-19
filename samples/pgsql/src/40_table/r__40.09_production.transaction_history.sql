CREATE TABLE IF NOT EXISTS production.transaction_history(
    transaction_id SERIAL NOT NULL
   ,product_id INT NOT NULL
   ,reference_order_id INT NOT NULL
   ,reference_order_line_id INT NOT NULL DEFAULT (0)
   ,transaction_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
   ,transaction_type char(1) NOT NULL
   ,quantity INT NOT NULL
   ,actual_cost NUMERIC NOT NULL
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);
  
COMMENT ON TABLE production.transaction_history IS 'Record of each purchase order, sales order, or work order transaction year to date.';
COMMENT ON COLUMN production.transaction_history.transaction_id IS 'Primary key for transaction_history records.';
COMMENT ON COLUMN production.transaction_history.product_id IS 'product identification number. foreign key to product.product_id.';
COMMENT ON COLUMN production.transaction_history.reference_order_id IS 'Purchase order, sales order, or work order identification number.';
COMMENT ON COLUMN production.transaction_history.reference_order_line_id IS 'Line number associated with the purchase order, sales order, or work order.';
COMMENT ON COLUMN production.transaction_history.transaction_date IS 'Date and time of the transaction.';
COMMENT ON COLUMN production.transaction_history.transaction_type IS 'W = work_order, S = sales_order, P = purchase_order';
COMMENT ON COLUMN production.transaction_history.quantity IS 'product quantity.';
COMMENT ON COLUMN production.transaction_history.actual_cost IS 'product cost.';