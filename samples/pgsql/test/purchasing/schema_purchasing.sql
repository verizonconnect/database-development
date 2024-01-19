SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(10);

SELECT tables_are('purchasing', ARRAY[
    'product_vendor',
    'purchase_order_detail',
    'purchase_order_header',
    'ship_method',
    'vendor'
]);

SELECT table_owner_is('purchasing','product_vendor','postgres','purchasing.product_vendor owner is postgres');
SELECT table_owner_is('purchasing','purchase_order_detail','postgres','purchasing.purchase_order_detail owner is postgres');
SELECT table_owner_is('purchasing','purchase_order_header','postgres','purchasing.purchase_order_header owner is postgres');
SELECT table_owner_is('purchasing','ship_method','postgres','purchasing.ship_method owner is postgres');
SELECT table_owner_is('purchasing','vendor','postgres','purchasing.vendor owner is postgres');
SELECT sequences_are('purchasing', ARRAY[
    'purchase_order_detail_purchase_order_detail_id_seq',
    'purchase_order_header_purchase_order_id_seq',
    'ship_method_ship_method_id_seq'
]);

SELECT sequence_owner_is('purchasing','purchase_order_detail_purchase_order_detail_id_seq','postgres','purchasing.purchase_order_detail_purchase_order_detail_id_seq owner is postgres');
SELECT sequence_owner_is('purchasing','purchase_order_header_purchase_order_id_seq','postgres','purchasing.purchase_order_header_purchase_order_id_seq owner is postgres');
SELECT sequence_owner_is('purchasing','ship_method_ship_method_id_seq','postgres','purchasing.ship_method_ship_method_id_seq owner is postgres');

SELECT * FROM finish();
ROLLBACK;
