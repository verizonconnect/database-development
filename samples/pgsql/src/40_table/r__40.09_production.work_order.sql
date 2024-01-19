CREATE TABLE IF NOT EXISTS production.work_order(
    work_order_id SERIAL NOT NULL
   ,product_id INT NOT NULL
   ,order_qty INT NOT NULL
   ,scrapped_qty SMALLINT NOT NULL
   ,start_date TIMESTAMP NOT NULL
   ,end_date TIMESTAMP NULL
   ,due_date TIMESTAMP NOT NULL
   ,scrap_reason_id SMALLINT NULL
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);

COMMENT ON TABLE production.work_order IS 'Manufacturing work orders.';
COMMENT ON COLUMN production.work_order.work_order_id IS 'Primary key for work_order records.';
COMMENT ON COLUMN production.work_order.product_id IS 'product identification number. foreign key to product.product_id.';
COMMENT ON COLUMN production.work_order.order_qty IS 'product quantity to build.';
COMMENT ON COLUMN production.work_order.scrapped_qty IS 'quantity that failed inspection.';
COMMENT ON COLUMN production.work_order.start_date IS 'Work order start date.';
COMMENT ON COLUMN production.work_order.end_date IS 'Work order end date.';
COMMENT ON COLUMN production.work_order.due_date IS 'Work order due date.';
COMMENT ON COLUMN production.work_order.scrap_reason_id IS 'Reason for inspection failure.';