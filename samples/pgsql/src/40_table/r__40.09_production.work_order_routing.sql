CREATE TABLE IF NOT EXISTS production.work_order_routing(
    work_order_id INT NOT NULL
   ,product_id INT NOT NULL
   ,operation_sequence SMALLINT NOT NULL
   ,location_id SMALLINT NOT NULL
   ,scheduled_start_date TIMESTAMP NOT NULL
   ,scheduled_end_date TIMESTAMP NOT NULL
   ,actual_start_date TIMESTAMP NULL
   ,actual_end_date TIMESTAMP NULL
   ,actual_resource_hrs DECIMAL(9, 4) NULL
   ,planned_cost NUMERIC NOT NULL
   ,actual_cost NUMERIC NULL
   ,modified_date TIMESTAMP NOT NULL DEFAULT (now() at time zone 'utc')
);

COMMENT ON TABLE production.work_order_routing IS 'Work order details.';
COMMENT ON COLUMN production.work_order_routing.work_order_id IS 'Primary key. foreign key to work_order.work_order_id.';
COMMENT ON COLUMN production.work_order_routing.product_id IS 'Primary key. foreign key to product.product_id.';
COMMENT ON COLUMN production.work_order_routing.operation_sequence IS 'Primary key. indicates the manufacturing process sequence.';
COMMENT ON COLUMN production.work_order_routing.location_id IS 'Manufacturing location where the part is processed. foreign key to location.location_id.';
COMMENT ON COLUMN production.work_order_routing.scheduled_start_date IS 'Planned manufacturing start date.';
COMMENT ON COLUMN production.work_order_routing.scheduled_end_date IS 'Planned manufacturing end date.';
COMMENT ON COLUMN production.work_order_routing.actual_start_date IS 'Actual start date.';
COMMENT ON COLUMN production.work_order_routing.actual_end_date IS 'Actual end date.';
COMMENT ON COLUMN production.work_order_routing.actual_resource_hrs IS 'Number of manufacturing hours used.';
COMMENT ON COLUMN production.work_order_routing.planned_cost IS 'Estimated manufacturing cost.';
COMMENT ON COLUMN production.work_order_routing.actual_cost IS 'Actual manufacturing cost.';
