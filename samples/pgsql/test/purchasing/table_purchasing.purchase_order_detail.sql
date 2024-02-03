SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(55);

SELECT has_table(
    'purchasing', 'purchase_order_detail',
    'Should have table purchasing.purchase_order_detail'
);

SELECT has_pk(
    'purchasing', 'purchase_order_detail',
    'Table purchasing.purchase_order_detail should have a primary key'
);

SELECT has_check(
    'purchasing', 'purchase_order_detail',
    'Table purchasing.purchase_order_detail should have check contraint(s)'
);

SELECT col_is_pk('purchasing'::name, 'purchase_order_detail'::name, ARRAY[
    'purchase_order_id'::name,
    'purchase_order_detail_id'::name
],
'Primary key definition is not as expected');

SELECT columns_are('purchasing'::name, 'purchase_order_detail'::name, ARRAY[
    'purchase_order_id'::name,
    'purchase_order_detail_id'::name,
    'due_date'::name,
    'order_qty'::name,
    'product_id'::name,
    'unit_price'::name,
    'line_total'::name,
    'received_qty'::name,
    'rejected_qty'::name,
    'stocked_qty'::name,
    'modified_date'::name
]);

SELECT has_column(       'purchasing', 'purchase_order_detail', 'purchase_order_id', 'Column purchasing.purchase_order_detail.purchase_order_id should exist');
SELECT col_type_is(      'purchasing', 'purchase_order_detail', 'purchase_order_id', 'integer', 'Column purchasing.purchase_order_detail.purchase_order_id should be type integer');
SELECT col_not_null(     'purchasing', 'purchase_order_detail', 'purchase_order_id', 'Column purchasing.purchase_order_detail.purchase_order_id should be NOT NULL');
SELECT col_hasnt_default('purchasing', 'purchase_order_detail', 'purchase_order_id', 'Column purchasing.purchase_order_detail.purchase_order_id should not have a default');

SELECT has_column(       'purchasing', 'purchase_order_detail', 'purchase_order_detail_id', 'Column purchasing.purchase_order_detail.purchase_order_detail_id should exist');
SELECT col_type_is(      'purchasing', 'purchase_order_detail', 'purchase_order_detail_id', 'integer', 'Column purchasing.purchase_order_detail.purchase_order_detail_id should be type integer');
SELECT col_not_null(     'purchasing', 'purchase_order_detail', 'purchase_order_detail_id', 'Column purchasing.purchase_order_detail.purchase_order_detail_id should be NOT NULL');
SELECT col_has_default(  'purchasing', 'purchase_order_detail', 'purchase_order_detail_id', 'Column purchasing.purchase_order_detail.purchase_order_detail_id should have a default');
SELECT col_default_is(   'purchasing', 'purchase_order_detail', 'purchase_order_detail_id', 'nextval(''purchasing.purchase_order_detail_purchase_order_detail_id_seq''::regclass)', 'Column purchasing.purchase_order_detail.purchase_order_detail_id default is');

SELECT has_column(       'purchasing', 'purchase_order_detail', 'due_date', 'Column purchasing.purchase_order_detail.due_date should exist');
SELECT col_type_is(      'purchasing', 'purchase_order_detail', 'due_date', 'timestamp without time zone', 'Column purchasing.purchase_order_detail.due_date should be type timestamp without time zone');
SELECT col_not_null(     'purchasing', 'purchase_order_detail', 'due_date', 'Column purchasing.purchase_order_detail.due_date should be NOT NULL');
SELECT col_hasnt_default('purchasing', 'purchase_order_detail', 'due_date', 'Column purchasing.purchase_order_detail.due_date should not have a default');

SELECT has_column(       'purchasing', 'purchase_order_detail', 'order_qty', 'Column purchasing.purchase_order_detail.order_qty should exist');
SELECT col_type_is(      'purchasing', 'purchase_order_detail', 'order_qty', 'smallint', 'Column purchasing.purchase_order_detail.order_qty should be type smallint');
SELECT col_not_null(     'purchasing', 'purchase_order_detail', 'order_qty', 'Column purchasing.purchase_order_detail.order_qty should be NOT NULL');
SELECT col_hasnt_default('purchasing', 'purchase_order_detail', 'order_qty', 'Column purchasing.purchase_order_detail.order_qty should not have a default');
SELECT col_has_check(    'purchasing', 'purchase_order_detail', 'order_qty', 'Column purchasing.purchase_order_detail.order_qty should have a check constraint');

SELECT has_column(       'purchasing', 'purchase_order_detail', 'product_id', 'Column purchasing.purchase_order_detail.product_id should exist');
SELECT col_type_is(      'purchasing', 'purchase_order_detail', 'product_id', 'integer', 'Column purchasing.purchase_order_detail.product_id should be type integer');
SELECT col_not_null(     'purchasing', 'purchase_order_detail', 'product_id', 'Column purchasing.purchase_order_detail.product_id should be NOT NULL');
SELECT col_hasnt_default('purchasing', 'purchase_order_detail', 'product_id', 'Column purchasing.purchase_order_detail.product_id should not have a default');

SELECT has_column(       'purchasing', 'purchase_order_detail', 'unit_price', 'Column purchasing.purchase_order_detail.unit_price should exist');
SELECT col_type_is(      'purchasing', 'purchase_order_detail', 'unit_price', 'numeric', 'Column purchasing.purchase_order_detail.unit_price should be type numeric');
SELECT col_not_null(     'purchasing', 'purchase_order_detail', 'unit_price', 'Column purchasing.purchase_order_detail.unit_price should be NOT NULL');
SELECT col_hasnt_default('purchasing', 'purchase_order_detail', 'unit_price', 'Column purchasing.purchase_order_detail.unit_price should not have a default');
SELECT col_has_check(    'purchasing', 'purchase_order_detail', 'unit_price', 'Column purchasing.purchase_order_detail.unit_price should have a check constraint');

SELECT has_column(       'purchasing', 'purchase_order_detail', 'line_total', 'Column purchasing.purchase_order_detail.line_total should exist');
SELECT col_type_is(      'purchasing', 'purchase_order_detail', 'line_total', 'numeric', 'Column purchasing.purchase_order_detail.line_total should be type numeric');
SELECT col_is_null(      'purchasing', 'purchase_order_detail', 'line_total', 'Column purchasing.purchase_order_detail.line_total should allow NULL');
SELECT col_hasnt_default('purchasing', 'purchase_order_detail', 'line_total', 'Column purchasing.purchase_order_detail.line_total should not have a default');

SELECT has_column(       'purchasing', 'purchase_order_detail', 'received_qty', 'Column purchasing.purchase_order_detail.received_qty should exist');
SELECT col_type_is(      'purchasing', 'purchase_order_detail', 'received_qty', 'numeric(8,2)', 'Column purchasing.purchase_order_detail.received_qty should be type numeric(8,2)');
SELECT col_not_null(     'purchasing', 'purchase_order_detail', 'received_qty', 'Column purchasing.purchase_order_detail.received_qty should be NOT NULL');
SELECT col_hasnt_default('purchasing', 'purchase_order_detail', 'received_qty', 'Column purchasing.purchase_order_detail.received_qty should not have a default');
SELECT col_has_check(    'purchasing', 'purchase_order_detail', 'received_qty', 'Column purchasing.purchase_order_detail.received_qty should have a check constraint');

SELECT has_column(       'purchasing', 'purchase_order_detail', 'rejected_qty', 'Column purchasing.purchase_order_detail.rejected_qty should exist');
SELECT col_type_is(      'purchasing', 'purchase_order_detail', 'rejected_qty', 'numeric(8,2)', 'Column purchasing.purchase_order_detail.rejected_qty should be type numeric(8,2)');
SELECT col_not_null(     'purchasing', 'purchase_order_detail', 'rejected_qty', 'Column purchasing.purchase_order_detail.rejected_qty should be NOT NULL');
SELECT col_hasnt_default('purchasing', 'purchase_order_detail', 'rejected_qty', 'Column purchasing.purchase_order_detail.rejected_qty should not have a default');
SELECT col_has_check(    'purchasing', 'purchase_order_detail', 'rejected_qty', 'Column purchasing.purchase_order_detail.rejected_qty should have a check constraint');

SELECT has_column(       'purchasing', 'purchase_order_detail', 'stocked_qty', 'Column purchasing.purchase_order_detail.stocked_qty should exist');
SELECT col_type_is(      'purchasing', 'purchase_order_detail', 'stocked_qty', 'numeric', 'Column purchasing.purchase_order_detail.stocked_qty should be type numeric');
SELECT col_is_null(      'purchasing', 'purchase_order_detail', 'stocked_qty', 'Column purchasing.purchase_order_detail.stocked_qty should allow NULL');
SELECT col_hasnt_default('purchasing', 'purchase_order_detail', 'stocked_qty', 'Column purchasing.purchase_order_detail.stocked_qty should not have a default');

SELECT has_column(       'purchasing', 'purchase_order_detail', 'modified_date', 'Column purchasing.purchase_order_detail.modified_date should exist');
SELECT col_type_is(      'purchasing', 'purchase_order_detail', 'modified_date', 'timestamp without time zone', 'Column purchasing.purchase_order_detail.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'purchasing', 'purchase_order_detail', 'modified_date', 'Column purchasing.purchase_order_detail.modified_date should be NOT NULL');
SELECT col_has_default(  'purchasing', 'purchase_order_detail', 'modified_date', 'Column purchasing.purchase_order_detail.modified_date should have a default');
SELECT col_default_is(   'purchasing', 'purchase_order_detail', 'modified_date', 'timezone(''utc''::text, now())', 'Column purchasing.purchase_order_detail.modified_date default is');

SELECT * FROM finish();
ROLLBACK;

