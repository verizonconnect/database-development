SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(40);

SELECT tables_are('production', ARRAY[
    'bill_of_materials',
    'culture',
    'document',
    'illustration',
    'location',
    'product',
    'product_category',
    'product_cost_history',
    'product_description',
    'product_document',
    'product_inventory',
    'product_list_price_history',
    'product_model',
    'product_model_illustration',
    'product_model_product_description_culture',
    'product_photo',
    'product_product_photo',
    'product_review',
    'product_sub_category',
    'scrap_reason',
    'transaction_history',
    'transaction_history_archive',
    'unit_measure',
    'work_order',
    'work_order_routing'
]);

SELECT table_owner_is('production','bill_of_materials','postgres','production.bill_of_materials owner is postgres');
SELECT table_owner_is('production','culture','postgres','production.culture owner is postgres');
SELECT table_owner_is('production','document','postgres','production.document owner is postgres');
SELECT table_owner_is('production','illustration','postgres','production.illustration owner is postgres');
SELECT table_owner_is('production','location','postgres','production.location owner is postgres');
SELECT table_owner_is('production','product','postgres','production.product owner is postgres');
SELECT table_owner_is('production','product_category','postgres','production.product_category owner is postgres');
SELECT table_owner_is('production','product_cost_history','postgres','production.product_cost_history owner is postgres');
SELECT table_owner_is('production','product_description','postgres','production.product_description owner is postgres');
SELECT table_owner_is('production','product_document','postgres','production.product_document owner is postgres');
SELECT table_owner_is('production','product_inventory','postgres','production.product_inventory owner is postgres');
SELECT table_owner_is('production','product_list_price_history','postgres','production.product_list_price_history owner is postgres');
SELECT table_owner_is('production','product_model','postgres','production.product_model owner is postgres');
SELECT table_owner_is('production','product_model_illustration','postgres','production.product_model_illustration owner is postgres');
SELECT table_owner_is('production','product_model_product_description_culture','postgres','production.product_model_product_description_culture owner is postgres');
SELECT table_owner_is('production','product_photo','postgres','production.product_photo owner is postgres');
SELECT table_owner_is('production','product_product_photo','postgres','production.product_product_photo owner is postgres');
SELECT table_owner_is('production','product_review','postgres','production.product_review owner is postgres');
SELECT table_owner_is('production','product_sub_category','postgres','production.product_sub_category owner is postgres');
SELECT table_owner_is('production','scrap_reason','postgres','production.scrap_reason owner is postgres');
SELECT table_owner_is('production','transaction_history','postgres','production.transaction_history owner is postgres');
SELECT table_owner_is('production','transaction_history_archive','postgres','production.transaction_history_archive owner is postgres');
SELECT table_owner_is('production','unit_measure','postgres','production.unit_measure owner is postgres');
SELECT table_owner_is('production','work_order','postgres','production.work_order owner is postgres');
SELECT table_owner_is('production','work_order_routing','postgres','production.work_order_routing owner is postgres');
SELECT sequences_are('production', ARRAY[
    'bill_of_materials_bill_of_materials_id_seq',
    'illustration_illustration_id_seq',
    'location_location_id_seq',
    'product_category_product_category_id_seq',
    'product_description_product_description_id_seq',
    'product_model_product_model_id_seq',
    'product_photo_product_photo_id_seq',
    'product_product_id_seq',
    'product_review_product_review_id_seq',
    'product_sub_category_product_sub_category_id_seq',
    'scrap_reason_scrap_reason_id_seq',
    'transaction_history_transaction_id_seq',
    'work_order_work_order_id_seq'
]);

SELECT sequence_owner_is('production','bill_of_materials_bill_of_materials_id_seq','postgres','production.bill_of_materials_bill_of_materials_id_seq owner is postgres');
SELECT sequence_owner_is('production','illustration_illustration_id_seq','postgres','production.illustration_illustration_id_seq owner is postgres');
SELECT sequence_owner_is('production','location_location_id_seq','postgres','production.location_location_id_seq owner is postgres');
SELECT sequence_owner_is('production','product_category_product_category_id_seq','postgres','production.product_category_product_category_id_seq owner is postgres');
SELECT sequence_owner_is('production','product_description_product_description_id_seq','postgres','production.product_description_product_description_id_seq owner is postgres');
SELECT sequence_owner_is('production','product_model_product_model_id_seq','postgres','production.product_model_product_model_id_seq owner is postgres');
SELECT sequence_owner_is('production','product_photo_product_photo_id_seq','postgres','production.product_photo_product_photo_id_seq owner is postgres');
SELECT sequence_owner_is('production','product_product_id_seq','postgres','production.product_product_id_seq owner is postgres');
SELECT sequence_owner_is('production','product_review_product_review_id_seq','postgres','production.product_review_product_review_id_seq owner is postgres');
SELECT sequence_owner_is('production','product_sub_category_product_sub_category_id_seq','postgres','production.product_sub_category_product_sub_category_id_seq owner is postgres');
SELECT sequence_owner_is('production','scrap_reason_scrap_reason_id_seq','postgres','production.scrap_reason_scrap_reason_id_seq owner is postgres');
SELECT sequence_owner_is('production','transaction_history_transaction_id_seq','postgres','production.transaction_history_transaction_id_seq owner is postgres');
SELECT sequence_owner_is('production','work_order_work_order_id_seq','postgres','production.work_order_work_order_id_seq owner is postgres');

SELECT * FROM finish();
ROLLBACK;
