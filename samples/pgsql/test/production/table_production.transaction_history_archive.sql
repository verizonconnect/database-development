SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(45);

SELECT has_table(
    'production', 'transaction_history_archive',
    'Should have table production.transaction_history_archive'
);

SELECT has_pk(
    'production', 'transaction_history_archive',
    'Table production.transaction_history_archive should have a primary key'
);

SELECT has_check(
    'production', 'transaction_history_archive',
    'Table production.transaction_history_archive should have check contraint(s)'
);

SELECT col_is_pk('production'::name, 'transaction_history_archive'::name, ARRAY[
    'transaction_id'::name
],
'Primary key definition is not as expected');

SELECT columns_are('production'::name, 'transaction_history_archive'::name, ARRAY[
    'transaction_id'::name,
    'product_id'::name,
    'reference_order_id'::name,
    'reference_order_line_id'::name,
    'transaction_date'::name,
    'transaction_type'::name,
    'quantity'::name,
    'actual_cost'::name,
    'modified_date'::name
]);

SELECT has_column(       'production', 'transaction_history_archive', 'transaction_id', 'Column production.transaction_history_archive.transaction_id should exist');
SELECT col_type_is(      'production', 'transaction_history_archive', 'transaction_id', 'integer', 'Column production.transaction_history_archive.transaction_id should be type integer');
SELECT col_not_null(     'production', 'transaction_history_archive', 'transaction_id', 'Column production.transaction_history_archive.transaction_id should be NOT NULL');
SELECT col_hasnt_default('production', 'transaction_history_archive', 'transaction_id', 'Column production.transaction_history_archive.transaction_id should not have a default');

SELECT has_column(       'production', 'transaction_history_archive', 'product_id', 'Column production.transaction_history_archive.product_id should exist');
SELECT col_type_is(      'production', 'transaction_history_archive', 'product_id', 'integer', 'Column production.transaction_history_archive.product_id should be type integer');
SELECT col_not_null(     'production', 'transaction_history_archive', 'product_id', 'Column production.transaction_history_archive.product_id should be NOT NULL');
SELECT col_hasnt_default('production', 'transaction_history_archive', 'product_id', 'Column production.transaction_history_archive.product_id should not have a default');

SELECT has_column(       'production', 'transaction_history_archive', 'reference_order_id', 'Column production.transaction_history_archive.reference_order_id should exist');
SELECT col_type_is(      'production', 'transaction_history_archive', 'reference_order_id', 'integer', 'Column production.transaction_history_archive.reference_order_id should be type integer');
SELECT col_not_null(     'production', 'transaction_history_archive', 'reference_order_id', 'Column production.transaction_history_archive.reference_order_id should be NOT NULL');
SELECT col_hasnt_default('production', 'transaction_history_archive', 'reference_order_id', 'Column production.transaction_history_archive.reference_order_id should not have a default');

SELECT has_column(       'production', 'transaction_history_archive', 'reference_order_line_id', 'Column production.transaction_history_archive.reference_order_line_id should exist');
SELECT col_type_is(      'production', 'transaction_history_archive', 'reference_order_line_id', 'integer', 'Column production.transaction_history_archive.reference_order_line_id should be type integer');
SELECT col_not_null(     'production', 'transaction_history_archive', 'reference_order_line_id', 'Column production.transaction_history_archive.reference_order_line_id should be NOT NULL');
SELECT col_has_default(  'production', 'transaction_history_archive', 'reference_order_line_id', 'Column production.transaction_history_archive.reference_order_line_id should have a default');
SELECT col_default_is(   'production', 'transaction_history_archive', 'reference_order_line_id', '0', 'Column production.transaction_history_archive.reference_order_line_id default is');

SELECT has_column(       'production', 'transaction_history_archive', 'transaction_date', 'Column production.transaction_history_archive.transaction_date should exist');
SELECT col_type_is(      'production', 'transaction_history_archive', 'transaction_date', 'timestamp without time zone', 'Column production.transaction_history_archive.transaction_date should be type timestamp without time zone');
SELECT col_not_null(     'production', 'transaction_history_archive', 'transaction_date', 'Column production.transaction_history_archive.transaction_date should be NOT NULL');
SELECT col_has_default(  'production', 'transaction_history_archive', 'transaction_date', 'Column production.transaction_history_archive.transaction_date should have a default');
SELECT col_default_is(   'production', 'transaction_history_archive', 'transaction_date', 'timezone(''utc''::text, now())', 'Column production.transaction_history_archive.transaction_date default is');

SELECT has_column(       'production', 'transaction_history_archive', 'transaction_type', 'Column production.transaction_history_archive.transaction_type should exist');
SELECT col_type_is(      'production', 'transaction_history_archive', 'transaction_type', 'character(1)', 'Column production.transaction_history_archive.transaction_type should be type character(1)');
SELECT col_not_null(     'production', 'transaction_history_archive', 'transaction_type', 'Column production.transaction_history_archive.transaction_type should be NOT NULL');
SELECT col_hasnt_default('production', 'transaction_history_archive', 'transaction_type', 'Column production.transaction_history_archive.transaction_type should not have a default');
SELECT col_has_check(    'production', 'transaction_history_archive', 'transaction_type', 'Column production.transaction_history_archive.transaction_type should have a check constraint');

SELECT has_column(       'production', 'transaction_history_archive', 'quantity', 'Column production.transaction_history_archive.quantity should exist');
SELECT col_type_is(      'production', 'transaction_history_archive', 'quantity', 'integer', 'Column production.transaction_history_archive.quantity should be type integer');
SELECT col_not_null(     'production', 'transaction_history_archive', 'quantity', 'Column production.transaction_history_archive.quantity should be NOT NULL');
SELECT col_hasnt_default('production', 'transaction_history_archive', 'quantity', 'Column production.transaction_history_archive.quantity should not have a default');

SELECT has_column(       'production', 'transaction_history_archive', 'actual_cost', 'Column production.transaction_history_archive.actual_cost should exist');
SELECT col_type_is(      'production', 'transaction_history_archive', 'actual_cost', 'numeric', 'Column production.transaction_history_archive.actual_cost should be type numeric');
SELECT col_not_null(     'production', 'transaction_history_archive', 'actual_cost', 'Column production.transaction_history_archive.actual_cost should be NOT NULL');
SELECT col_hasnt_default('production', 'transaction_history_archive', 'actual_cost', 'Column production.transaction_history_archive.actual_cost should not have a default');

SELECT has_column(       'production', 'transaction_history_archive', 'modified_date', 'Column production.transaction_history_archive.modified_date should exist');
SELECT col_type_is(      'production', 'transaction_history_archive', 'modified_date', 'timestamp without time zone', 'Column production.transaction_history_archive.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'production', 'transaction_history_archive', 'modified_date', 'Column production.transaction_history_archive.modified_date should be NOT NULL');
SELECT col_has_default(  'production', 'transaction_history_archive', 'modified_date', 'Column production.transaction_history_archive.modified_date should have a default');
SELECT col_default_is(   'production', 'transaction_history_archive', 'modified_date', 'timezone(''utc''::text, now())', 'Column production.transaction_history_archive.modified_date default is');

SELECT * FROM finish();
ROLLBACK;

