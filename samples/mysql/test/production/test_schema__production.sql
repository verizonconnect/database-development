USE tap;
BEGIN;
SELECT tap.plan(75);

-- production.bill_of_materials
SELECT tap.has_table('production','bill_of_materials','');
SELECT tap.table_engine_is('production','bill_of_materials','InnoDB','');
SELECT tap.columns_are('production','bill_of_materials','`bill_of_materials_id`,`product_assembly_id`,`component_id`,`start_date`,`end_date`,`unit_measure_code`,`bom_level`,`per_assembly_qty`,`modified_date`','');

-- production.culture
SELECT tap.has_table('production','culture','');
SELECT tap.table_engine_is('production','culture','InnoDB','');
SELECT tap.columns_are('production','culture','`culture_id`,`name`,`modified_date`','');

-- production.document
SELECT tap.has_table('production','document','');
SELECT tap.table_engine_is('production','document','InnoDB','');
SELECT tap.columns_are('production','document','`document_node`,`title`,`owner`,`folder_flag`,`file_name`,`file_extension`,`revision`,`change_number`,`status`,`document_summary`,`document`,`rowguid`,`modified_date`','');

-- production.illustration
SELECT tap.has_table('production','illustration','');
SELECT tap.table_engine_is('production','illustration','InnoDB','');
SELECT tap.columns_are('production','illustration','`illustration_id`,`diagram`,`modified_date`','');

-- production.location
SELECT tap.has_table('production','location','');
SELECT tap.table_engine_is('production','location','InnoDB','');
SELECT tap.columns_are('production','location','`location_id`,`name`,`cost_rate`,`availability`,`modified_date`','');

-- production.product
SELECT tap.has_table('production','product','');
SELECT tap.table_engine_is('production','product','InnoDB','');
SELECT tap.columns_are('production','product','`product_id`,`name`,`product_number`,`make_flag`,`finished_goods_flag`,`colour`,`safety_stock_level`,`reorder_point`,`standard_cost`,`list_price`,`size`,`size_unit_measure_code`,`weight_unit_measure_code`,`weight`,`days_to_manufacture`,`product_line`,`class`,`style`,`product_sub_category_id`,`product_model_id`,`sell_start_date`,`sell_end_date`,`discontinued_date`,`rowguid`,`modified_date`','');

-- production.product_category
SELECT tap.has_table('production','product_category','');
SELECT tap.table_engine_is('production','product_category','InnoDB','');
SELECT tap.columns_are('production','product_category','`product_category_id`,`name`,`rowguid`,`modified_date`','');

-- production.product_cost_history
SELECT tap.has_table('production','product_cost_history','');
SELECT tap.table_engine_is('production','product_cost_history','InnoDB','');
SELECT tap.columns_are('production','product_cost_history','`product_id`,`start_date`,`end_date`,`standard_cost`,`modified_date`','');

-- production.product_description
SELECT tap.has_table('production','product_description','');
SELECT tap.table_engine_is('production','product_description','InnoDB','');
SELECT tap.columns_are('production','product_description','`product_description_id`,`description`,`rowguid`,`modified_date`','');

-- production.product_document
SELECT tap.has_table('production','product_document','');
SELECT tap.table_engine_is('production','product_document','InnoDB','');
SELECT tap.columns_are('production','product_document','`product_id`,`document_node`,`modified_date`','');

-- production.product_inventory
SELECT tap.has_table('production','product_inventory','');
SELECT tap.table_engine_is('production','product_inventory','InnoDB','');
SELECT tap.columns_are('production','product_inventory','`product_id`,`location_id`,`shelf`,`bin`,`quantity`,`rowguid`,`modified_date`','');

-- production.product_list_price_history
SELECT tap.has_table('production','product_list_price_history','');
SELECT tap.table_engine_is('production','product_list_price_history','InnoDB','');
SELECT tap.columns_are('production','product_list_price_history','`product_id`,`start_date`,`end_date`,`list_price`,`modified_date`','');

-- production.product_model
SELECT tap.has_table('production','product_model','');
SELECT tap.table_engine_is('production','product_model','InnoDB','');
SELECT tap.columns_are('production','product_model','`product_model_id`,`name`,`catalog_description`,`instructions`,`rowguid`,`modified_date`','');

-- production.product_model_illustration
SELECT tap.has_table('production','product_model_illustration','');
SELECT tap.table_engine_is('production','product_model_illustration','InnoDB','');
SELECT tap.columns_are('production','product_model_illustration','`product_model_id`,`illustration_id`,`modified_date`','');

-- production.product_model_product_description_culture
SELECT tap.has_table('production','product_model_product_description_culture','');
SELECT tap.table_engine_is('production','product_model_product_description_culture','InnoDB','');
SELECT tap.columns_are('production','product_model_product_description_culture','`product_model_id`,`product_description_id`,`culture_id`,`modified_date`','');

-- production.product_photo
SELECT tap.has_table('production','product_photo','');
SELECT tap.table_engine_is('production','product_photo','InnoDB','');
SELECT tap.columns_are('production','product_photo','`product_photo_id`,`thumb_nail_photo`,`thumb_nail_photo_file_name`,`large_photo`,`large_photo_file_name`,`modified_date`','');

-- production.product_product_photo
SELECT tap.has_table('production','product_product_photo','');
SELECT tap.table_engine_is('production','product_product_photo','InnoDB','');
SELECT tap.columns_are('production','product_product_photo','`product_id`,`product_photo_id`,`primary`,`modified_date`','');

-- production.product_review
SELECT tap.has_table('production','product_review','');
SELECT tap.table_engine_is('production','product_review','InnoDB','');
SELECT tap.columns_are('production','product_review','`product_review_id`,`product_id`,`reviewer_name`,`review_date`,`email_address`,`rating`,`comments`,`modified_date`','');

-- production.product_sub_category
SELECT tap.has_table('production','product_sub_category','');
SELECT tap.table_engine_is('production','product_sub_category','InnoDB','');
SELECT tap.columns_are('production','product_sub_category','`product_sub_category_id`,`product_category_id`,`name`,`rowguid`,`modified_date`','');

-- production.scrap_reason
SELECT tap.has_table('production','scrap_reason','');
SELECT tap.table_engine_is('production','scrap_reason','InnoDB','');
SELECT tap.columns_are('production','scrap_reason','`scrap_reason_id`,`name`,`modified_date`','');

-- production.transaction_history
SELECT tap.has_table('production','transaction_history','');
SELECT tap.table_engine_is('production','transaction_history','InnoDB','');
SELECT tap.columns_are('production','transaction_history','`transaction_id`,`product_id`,`reference_order_id`,`reference_order_line_id`,`transaction_date`,`transaction_type`,`quantity`,`actual_cost`,`modified_date`','');

-- production.transaction_history_archive
SELECT tap.has_table('production','transaction_history_archive','');
SELECT tap.table_engine_is('production','transaction_history_archive','InnoDB','');
SELECT tap.columns_are('production','transaction_history_archive','`transaction_id`,`product_id`,`reference_order_id`,`reference_order_line_id`,`transaction_date`,`transaction_type`,`quantity`,`actual_cost`,`modified_date`','');

-- production.unit_measure
SELECT tap.has_table('production','unit_measure','');
SELECT tap.table_engine_is('production','unit_measure','InnoDB','');
SELECT tap.columns_are('production','unit_measure','`unit_measure_code`,`name`,`modified_date`','');

-- production.work_order
SELECT tap.has_table('production','work_order','');
SELECT tap.table_engine_is('production','work_order','InnoDB','');
SELECT tap.columns_are('production','work_order','`work_order_id`,`product_id`,`order_qty`,`scrapped_qty`,`start_date`,`end_date`,`due_date`,`scrap_reason_id`,`modified_date`','');

-- production.work_order_routing
SELECT tap.has_table('production','work_order_routing','');
SELECT tap.table_engine_is('production','work_order_routing','InnoDB','');
SELECT tap.columns_are('production','work_order_routing','`work_order_id`,`product_id`,`operation_sequence`,`location_id`,`scheduled_start_date`,`scheduled_end_date`,`actual_start_date`,`actual_end_date`,`actual_resource_hrs`,`planned_cost`,`actual_cost`,`modified_date`','');

CALL tap.finish();
ROLLBACK;
