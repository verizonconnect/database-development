SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(51);

SELECT has_table(
    'sales', 'sales_order_detail',
    'Should have table sales.sales_order_detail'
);

SELECT hasnt_pk(
    'sales', 'sales_order_detail',
    'Table sales.sales_order_detail should have a primary key'
);

SELECT columns_are('sales'::name, 'sales_order_detail'::name, ARRAY[
    'sales_order_id'::name,
    'sales_order_detail_id'::name,
    'carrier_tracking_number'::name,
    'order_qty'::name,
    'product_id'::name,
    'special_offer_id'::name,
    'unit_price'::name,
    'unit_price_discount'::name,
    'line_total'::name,
    'rowguid'::name,
    'modified_date'::name
]);

SELECT has_column(       'sales', 'sales_order_detail', 'sales_order_id', 'Column sales.sales_order_detail.sales_order_id should exist');
SELECT col_type_is(      'sales', 'sales_order_detail', 'sales_order_id', 'integer', 'Column sales.sales_order_detail.sales_order_id should be type integer');
SELECT col_not_null(     'sales', 'sales_order_detail', 'sales_order_id', 'Column sales.sales_order_detail.sales_order_id should be NOT NULL');
SELECT col_hasnt_default('sales', 'sales_order_detail', 'sales_order_id', 'Column sales.sales_order_detail.sales_order_id should not have a default');

SELECT has_column(       'sales', 'sales_order_detail', 'sales_order_detail_id', 'Column sales.sales_order_detail.sales_order_detail_id should exist');
SELECT col_type_is(      'sales', 'sales_order_detail', 'sales_order_detail_id', 'integer', 'Column sales.sales_order_detail.sales_order_detail_id should be type integer');
SELECT col_not_null(     'sales', 'sales_order_detail', 'sales_order_detail_id', 'Column sales.sales_order_detail.sales_order_detail_id should be NOT NULL');
SELECT col_has_default(  'sales', 'sales_order_detail', 'sales_order_detail_id', 'Column sales.sales_order_detail.sales_order_detail_id should have a default');
SELECT col_default_is(   'sales', 'sales_order_detail', 'sales_order_detail_id', 'nextval(''sales.sales_order_detail_sales_order_detail_id_seq''::regclass)', 'Column sales.sales_order_detail.sales_order_detail_id default is');

SELECT has_column(       'sales', 'sales_order_detail', 'carrier_tracking_number', 'Column sales.sales_order_detail.carrier_tracking_number should exist');
SELECT col_type_is(      'sales', 'sales_order_detail', 'carrier_tracking_number', 'character varying(25)', 'Column sales.sales_order_detail.carrier_tracking_number should be type character varying(25)');
SELECT col_is_null(      'sales', 'sales_order_detail', 'carrier_tracking_number', 'Column sales.sales_order_detail.carrier_tracking_number should allow NULL');
SELECT col_hasnt_default('sales', 'sales_order_detail', 'carrier_tracking_number', 'Column sales.sales_order_detail.carrier_tracking_number should not have a default');

SELECT has_column(       'sales', 'sales_order_detail', 'order_qty', 'Column sales.sales_order_detail.order_qty should exist');
SELECT col_type_is(      'sales', 'sales_order_detail', 'order_qty', 'smallint', 'Column sales.sales_order_detail.order_qty should be type smallint');
SELECT col_not_null(     'sales', 'sales_order_detail', 'order_qty', 'Column sales.sales_order_detail.order_qty should be NOT NULL');
SELECT col_hasnt_default('sales', 'sales_order_detail', 'order_qty', 'Column sales.sales_order_detail.order_qty should not have a default');

SELECT has_column(       'sales', 'sales_order_detail', 'product_id', 'Column sales.sales_order_detail.product_id should exist');
SELECT col_type_is(      'sales', 'sales_order_detail', 'product_id', 'integer', 'Column sales.sales_order_detail.product_id should be type integer');
SELECT col_not_null(     'sales', 'sales_order_detail', 'product_id', 'Column sales.sales_order_detail.product_id should be NOT NULL');
SELECT col_hasnt_default('sales', 'sales_order_detail', 'product_id', 'Column sales.sales_order_detail.product_id should not have a default');

SELECT has_column(       'sales', 'sales_order_detail', 'special_offer_id', 'Column sales.sales_order_detail.special_offer_id should exist');
SELECT col_type_is(      'sales', 'sales_order_detail', 'special_offer_id', 'integer', 'Column sales.sales_order_detail.special_offer_id should be type integer');
SELECT col_not_null(     'sales', 'sales_order_detail', 'special_offer_id', 'Column sales.sales_order_detail.special_offer_id should be NOT NULL');
SELECT col_hasnt_default('sales', 'sales_order_detail', 'special_offer_id', 'Column sales.sales_order_detail.special_offer_id should not have a default');

SELECT has_column(       'sales', 'sales_order_detail', 'unit_price', 'Column sales.sales_order_detail.unit_price should exist');
SELECT col_type_is(      'sales', 'sales_order_detail', 'unit_price', 'numeric', 'Column sales.sales_order_detail.unit_price should be type numeric');
SELECT col_not_null(     'sales', 'sales_order_detail', 'unit_price', 'Column sales.sales_order_detail.unit_price should be NOT NULL');
SELECT col_hasnt_default('sales', 'sales_order_detail', 'unit_price', 'Column sales.sales_order_detail.unit_price should not have a default');

SELECT has_column(       'sales', 'sales_order_detail', 'unit_price_discount', 'Column sales.sales_order_detail.unit_price_discount should exist');
SELECT col_type_is(      'sales', 'sales_order_detail', 'unit_price_discount', 'numeric', 'Column sales.sales_order_detail.unit_price_discount should be type numeric');
SELECT col_not_null(     'sales', 'sales_order_detail', 'unit_price_discount', 'Column sales.sales_order_detail.unit_price_discount should be NOT NULL');
SELECT col_has_default(  'sales', 'sales_order_detail', 'unit_price_discount', 'Column sales.sales_order_detail.unit_price_discount should have a default');
SELECT col_default_is(   'sales', 'sales_order_detail', 'unit_price_discount', '0.0', 'Column sales.sales_order_detail.unit_price_discount default is');

SELECT has_column(       'sales', 'sales_order_detail', 'line_total', 'Column sales.sales_order_detail.line_total should exist');
SELECT col_type_is(      'sales', 'sales_order_detail', 'line_total', 'numeric', 'Column sales.sales_order_detail.line_total should be type numeric');
SELECT col_is_null(      'sales', 'sales_order_detail', 'line_total', 'Column sales.sales_order_detail.line_total should allow NULL');
SELECT col_hasnt_default('sales', 'sales_order_detail', 'line_total', 'Column sales.sales_order_detail.line_total should not have a default');

SELECT has_column(       'sales', 'sales_order_detail', 'rowguid', 'Column sales.sales_order_detail.rowguid should exist');
SELECT col_type_is(      'sales', 'sales_order_detail', 'rowguid', 'uuid', 'Column sales.sales_order_detail.rowguid should be type uuid');
SELECT col_not_null(     'sales', 'sales_order_detail', 'rowguid', 'Column sales.sales_order_detail.rowguid should be NOT NULL');
SELECT col_has_default(  'sales', 'sales_order_detail', 'rowguid', 'Column sales.sales_order_detail.rowguid should have a default');
SELECT col_default_is(   'sales', 'sales_order_detail', 'rowguid', 'common.uuid_generate_v1()', 'Column sales.sales_order_detail.rowguid default is');

SELECT has_column(       'sales', 'sales_order_detail', 'modified_date', 'Column sales.sales_order_detail.modified_date should exist');
SELECT col_type_is(      'sales', 'sales_order_detail', 'modified_date', 'timestamp without time zone', 'Column sales.sales_order_detail.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'sales', 'sales_order_detail', 'modified_date', 'Column sales.sales_order_detail.modified_date should be NOT NULL');
SELECT col_has_default(  'sales', 'sales_order_detail', 'modified_date', 'Column sales.sales_order_detail.modified_date should have a default');
SELECT col_default_is(   'sales', 'sales_order_detail', 'modified_date', 'timezone(''utc''::text, now())', 'Column sales.sales_order_detail.modified_date default is');

SELECT * FROM finish();
ROLLBACK;
