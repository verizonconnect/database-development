SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(16);

SELECT has_table(
    'sales', 'sales_order_header_sales_reason',
    'Should have table sales.sales_order_header_sales_reason'
);

SELECT hasnt_pk(
    'sales', 'sales_order_header_sales_reason',
    'Table sales.sales_order_header_sales_reason should have a primary key'
);

SELECT columns_are('sales'::name, 'sales_order_header_sales_reason'::name, ARRAY[
    'sales_order_id'::name,
    'sales_reason_id'::name,
    'modified_date'::name
]);

SELECT has_column(       'sales', 'sales_order_header_sales_reason', 'sales_order_id', 'Column sales.sales_order_header_sales_reason.sales_order_id should exist');
SELECT col_type_is(      'sales', 'sales_order_header_sales_reason', 'sales_order_id', 'integer', 'Column sales.sales_order_header_sales_reason.sales_order_id should be type integer');
SELECT col_not_null(     'sales', 'sales_order_header_sales_reason', 'sales_order_id', 'Column sales.sales_order_header_sales_reason.sales_order_id should be NOT NULL');
SELECT col_hasnt_default('sales', 'sales_order_header_sales_reason', 'sales_order_id', 'Column sales.sales_order_header_sales_reason.sales_order_id should not have a default');

SELECT has_column(       'sales', 'sales_order_header_sales_reason', 'sales_reason_id', 'Column sales.sales_order_header_sales_reason.sales_reason_id should exist');
SELECT col_type_is(      'sales', 'sales_order_header_sales_reason', 'sales_reason_id', 'integer', 'Column sales.sales_order_header_sales_reason.sales_reason_id should be type integer');
SELECT col_not_null(     'sales', 'sales_order_header_sales_reason', 'sales_reason_id', 'Column sales.sales_order_header_sales_reason.sales_reason_id should be NOT NULL');
SELECT col_hasnt_default('sales', 'sales_order_header_sales_reason', 'sales_reason_id', 'Column sales.sales_order_header_sales_reason.sales_reason_id should not have a default');

SELECT has_column(       'sales', 'sales_order_header_sales_reason', 'modified_date', 'Column sales.sales_order_header_sales_reason.modified_date should exist');
SELECT col_type_is(      'sales', 'sales_order_header_sales_reason', 'modified_date', 'timestamp without time zone', 'Column sales.sales_order_header_sales_reason.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'sales', 'sales_order_header_sales_reason', 'modified_date', 'Column sales.sales_order_header_sales_reason.modified_date should be NOT NULL');
SELECT col_has_default(  'sales', 'sales_order_header_sales_reason', 'modified_date', 'Column sales.sales_order_header_sales_reason.modified_date should have a default');
SELECT col_default_is(   'sales', 'sales_order_header_sales_reason', 'modified_date', 'timezone(''utc''::text, now())', 'Column sales.sales_order_header_sales_reason.modified_date default is');

SELECT * FROM finish();
ROLLBACK;
