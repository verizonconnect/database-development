SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(48);

SELECT has_table(
    'purchasing', 'product_vendor',
    'Should have table purchasing.product_vendor'
);

SELECT hasnt_pk(
    'purchasing', 'product_vendor',
    'Table purchasing.product_vendor should have a primary key'
);

SELECT columns_are('purchasing'::name, 'product_vendor'::name, ARRAY[
    'product_id'::name,
    'business_entity_id'::name,
    'average_lead_time'::name,
    'standard_price'::name,
    'last_receipt_cost'::name,
    'last_receipt_date'::name,
    'min_order_qty'::name,
    'max_order_qty'::name,
    'on_order_qty'::name,
    'unit_measure_code'::name,
    'modified_date'::name
]);

SELECT has_column(       'purchasing', 'product_vendor', 'product_id', 'Column purchasing.product_vendor.product_id should exist');
SELECT col_type_is(      'purchasing', 'product_vendor', 'product_id', 'integer', 'Column purchasing.product_vendor.product_id should be type integer');
SELECT col_not_null(     'purchasing', 'product_vendor', 'product_id', 'Column purchasing.product_vendor.product_id should be NOT NULL');
SELECT col_hasnt_default('purchasing', 'product_vendor', 'product_id', 'Column purchasing.product_vendor.product_id should not have a default');

SELECT has_column(       'purchasing', 'product_vendor', 'business_entity_id', 'Column purchasing.product_vendor.business_entity_id should exist');
SELECT col_type_is(      'purchasing', 'product_vendor', 'business_entity_id', 'integer', 'Column purchasing.product_vendor.business_entity_id should be type integer');
SELECT col_not_null(     'purchasing', 'product_vendor', 'business_entity_id', 'Column purchasing.product_vendor.business_entity_id should be NOT NULL');
SELECT col_hasnt_default('purchasing', 'product_vendor', 'business_entity_id', 'Column purchasing.product_vendor.business_entity_id should not have a default');

SELECT has_column(       'purchasing', 'product_vendor', 'average_lead_time', 'Column purchasing.product_vendor.average_lead_time should exist');
SELECT col_type_is(      'purchasing', 'product_vendor', 'average_lead_time', 'integer', 'Column purchasing.product_vendor.average_lead_time should be type integer');
SELECT col_not_null(     'purchasing', 'product_vendor', 'average_lead_time', 'Column purchasing.product_vendor.average_lead_time should be NOT NULL');
SELECT col_hasnt_default('purchasing', 'product_vendor', 'average_lead_time', 'Column purchasing.product_vendor.average_lead_time should not have a default');

SELECT has_column(       'purchasing', 'product_vendor', 'standard_price', 'Column purchasing.product_vendor.standard_price should exist');
SELECT col_type_is(      'purchasing', 'product_vendor', 'standard_price', 'numeric', 'Column purchasing.product_vendor.standard_price should be type numeric');
SELECT col_not_null(     'purchasing', 'product_vendor', 'standard_price', 'Column purchasing.product_vendor.standard_price should be NOT NULL');
SELECT col_hasnt_default('purchasing', 'product_vendor', 'standard_price', 'Column purchasing.product_vendor.standard_price should not have a default');

SELECT has_column(       'purchasing', 'product_vendor', 'last_receipt_cost', 'Column purchasing.product_vendor.last_receipt_cost should exist');
SELECT col_type_is(      'purchasing', 'product_vendor', 'last_receipt_cost', 'numeric', 'Column purchasing.product_vendor.last_receipt_cost should be type numeric');
SELECT col_is_null(      'purchasing', 'product_vendor', 'last_receipt_cost', 'Column purchasing.product_vendor.last_receipt_cost should allow NULL');
SELECT col_hasnt_default('purchasing', 'product_vendor', 'last_receipt_cost', 'Column purchasing.product_vendor.last_receipt_cost should not have a default');

SELECT has_column(       'purchasing', 'product_vendor', 'last_receipt_date', 'Column purchasing.product_vendor.last_receipt_date should exist');
SELECT col_type_is(      'purchasing', 'product_vendor', 'last_receipt_date', 'timestamp without time zone', 'Column purchasing.product_vendor.last_receipt_date should be type timestamp without time zone');
SELECT col_is_null(      'purchasing', 'product_vendor', 'last_receipt_date', 'Column purchasing.product_vendor.last_receipt_date should allow NULL');
SELECT col_hasnt_default('purchasing', 'product_vendor', 'last_receipt_date', 'Column purchasing.product_vendor.last_receipt_date should not have a default');

SELECT has_column(       'purchasing', 'product_vendor', 'min_order_qty', 'Column purchasing.product_vendor.min_order_qty should exist');
SELECT col_type_is(      'purchasing', 'product_vendor', 'min_order_qty', 'integer', 'Column purchasing.product_vendor.min_order_qty should be type integer');
SELECT col_not_null(     'purchasing', 'product_vendor', 'min_order_qty', 'Column purchasing.product_vendor.min_order_qty should be NOT NULL');
SELECT col_hasnt_default('purchasing', 'product_vendor', 'min_order_qty', 'Column purchasing.product_vendor.min_order_qty should not have a default');

SELECT has_column(       'purchasing', 'product_vendor', 'max_order_qty', 'Column purchasing.product_vendor.max_order_qty should exist');
SELECT col_type_is(      'purchasing', 'product_vendor', 'max_order_qty', 'integer', 'Column purchasing.product_vendor.max_order_qty should be type integer');
SELECT col_not_null(     'purchasing', 'product_vendor', 'max_order_qty', 'Column purchasing.product_vendor.max_order_qty should be NOT NULL');
SELECT col_hasnt_default('purchasing', 'product_vendor', 'max_order_qty', 'Column purchasing.product_vendor.max_order_qty should not have a default');

SELECT has_column(       'purchasing', 'product_vendor', 'on_order_qty', 'Column purchasing.product_vendor.on_order_qty should exist');
SELECT col_type_is(      'purchasing', 'product_vendor', 'on_order_qty', 'integer', 'Column purchasing.product_vendor.on_order_qty should be type integer');
SELECT col_is_null(      'purchasing', 'product_vendor', 'on_order_qty', 'Column purchasing.product_vendor.on_order_qty should allow NULL');
SELECT col_hasnt_default('purchasing', 'product_vendor', 'on_order_qty', 'Column purchasing.product_vendor.on_order_qty should not have a default');

SELECT has_column(       'purchasing', 'product_vendor', 'unit_measure_code', 'Column purchasing.product_vendor.unit_measure_code should exist');
SELECT col_type_is(      'purchasing', 'product_vendor', 'unit_measure_code', 'character(3)', 'Column purchasing.product_vendor.unit_measure_code should be type character(3)');
SELECT col_not_null(     'purchasing', 'product_vendor', 'unit_measure_code', 'Column purchasing.product_vendor.unit_measure_code should be NOT NULL');
SELECT col_hasnt_default('purchasing', 'product_vendor', 'unit_measure_code', 'Column purchasing.product_vendor.unit_measure_code should not have a default');

SELECT has_column(       'purchasing', 'product_vendor', 'modified_date', 'Column purchasing.product_vendor.modified_date should exist');
SELECT col_type_is(      'purchasing', 'product_vendor', 'modified_date', 'timestamp without time zone', 'Column purchasing.product_vendor.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'purchasing', 'product_vendor', 'modified_date', 'Column purchasing.product_vendor.modified_date should be NOT NULL');
SELECT col_has_default(  'purchasing', 'product_vendor', 'modified_date', 'Column purchasing.product_vendor.modified_date should have a default');
SELECT col_default_is(   'purchasing', 'product_vendor', 'modified_date', 'timezone(''utc''::text, now())', 'Column purchasing.product_vendor.modified_date default is');

SELECT * FROM finish();
ROLLBACK;
