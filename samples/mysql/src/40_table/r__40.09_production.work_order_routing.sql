CREATE TABLE IF NOT EXISTS production.work_order_routing(
    work_order_id INT NOT NULL COMMENT 'Primary key. foreign key to work_order.work_order_id.'
   ,product_id INT NOT NULL COMMENT 'Primary key. foreign key to product.product_id.'
   ,operation_sequence SMALLINT NOT NULL COMMENT 'Primary key. indicates the manufacturing process sequence.'
   ,location_id SMALLINT NOT NULL COMMENT 'Manufacturing location where the part is processed. foreign key to location.location_id.'
   ,scheduled_start_date DATETIME NOT NULL COMMENT 'Planned manufacturing start date.'
   ,scheduled_end_date DATETIME NOT NULL COMMENT 'Planned manufacturing end date.'
   ,actual_start_date DATETIME NULL COMMENT 'Actual start date.'
   ,actual_end_date DATETIME NULL COMMENT 'Actual end date.'
   ,actual_resource_hrs DECIMAL(9, 4) NULL COMMENT 'Number of manufacturing hours used.'
   ,planned_cost DECIMAL(19,4) NOT NULL COMMENT 'Estimated manufacturing cost.'
   ,actual_cost DECIMAL(19,4) NULL COMMENT 'Actual manufacturing cost.'
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())
   ,CONSTRAINT `pk_work_order_routing` PRIMARY KEY (work_order_id, product_id, operation_sequence)
)
COMMENT 'Work order details.';
