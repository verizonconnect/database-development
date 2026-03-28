CREATE TABLE IF NOT EXISTS production.work_order(
    work_order_id INT AUTO_INCREMENT NOT NULL COMMENT 'Primary key for work_order records.'
   ,product_id INT NOT NULL COMMENT 'product identification number. foreign key to product.product_id.'
   ,order_qty INT NOT NULL COMMENT 'product quantity to build.'
   ,scrapped_qty SMALLINT NOT NULL COMMENT 'quantity that failed inspection.'
   ,start_date DATETIME NOT NULL COMMENT 'Work order start date.'
   ,end_date DATETIME NULL COMMENT 'Work order end date.'
   ,due_date DATETIME NOT NULL COMMENT 'Work order due date.'
   ,scrap_reason_id SMALLINT NULL COMMENT 'Reason for inspection failure.'
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())

   ,CONSTRAINT `pk_work_order` PRIMARY KEY (work_order_id)
)
COMMENT 'Manufacturing work orders.';
