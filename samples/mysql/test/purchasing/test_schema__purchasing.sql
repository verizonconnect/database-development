USE tap;
BEGIN;
SELECT tap.plan(15);

-- purchasing.product_vendor
SELECT tap.has_table('purchasing','product_vendor','');
SELECT tap.table_engine_is('purchasing','product_vendor','InnoDB','');
SELECT tap.columns_are('purchasing','product_vendor','`product_id`,`business_entity_id`,`average_lead_time`,`standard_price`,`last_receipt_cost`,`last_receipt_date`,`min_order_qty`,`max_order_qty`,`on_order_qty`,`unit_measure_code`,`modified_date`','');

-- purchasing.purchase_order_detail
SELECT tap.has_table('purchasing','purchase_order_detail','');
SELECT tap.table_engine_is('purchasing','purchase_order_detail','InnoDB','');
SELECT tap.columns_are('purchasing','purchase_order_detail','`purchase_order_id`,`purchase_order_detail_id`,`due_date`,`order_qty`,`product_id`,`unit_price`,`line_total`,`received_qty`,`rejected_qty`,`stocked_qty`,`modified_date`','');

-- purchasing.purchase_order_header
SELECT tap.has_table('purchasing','purchase_order_header','');
SELECT tap.table_engine_is('purchasing','purchase_order_header','InnoDB','');
SELECT tap.columns_are('purchasing','purchase_order_header','`purchase_order_id`,`revision_number`,`status`,`employee_id`,`vendor_id`,`ship_method_id`,`order_date`,`ship_date`,`sub_total`,`tax_amt`,`freight`,`total_due`,`modified_date`','');

-- purchasing.ship_method
SELECT tap.has_table('purchasing','ship_method','');
SELECT tap.table_engine_is('purchasing','ship_method','InnoDB','');
SELECT tap.columns_are('purchasing','ship_method','`ship_method_id`,`name`,`ship_base`,`ship_rate`,`rowguid`,`modified_date`','');

-- purchasing.vendor
SELECT tap.has_table('purchasing','vendor','');
SELECT tap.table_engine_is('purchasing','vendor','InnoDB','');
SELECT tap.columns_are('purchasing','vendor','`business_entity_id`,`account_number`,`name`,`credit_rating`,`preferred_vendor_status`,`active_flag`,`purchasing_web_service_url`,`modified_date`','');

CALL tap.finish();
ROLLBACK;
