SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(22);

SELECT has_table(
    'sales', 'sales_reason',
    'Should have table sales.sales_reason'
);

SELECT has_pk(
    'sales', 'sales_reason',
    'Table sales.sales_reason should have a primary key'
);

SELECT col_is_pk('sales'::name, 'sales_reason'::name, ARRAY[
    'sales_reason_id'::name
],
'Primary key definition is not as expected');

SELECT columns_are('sales'::name, 'sales_reason'::name, ARRAY[
    'sales_reason_id'::name,
    'name'::name,
    'reason_type'::name,
    'modified_date'::name
]);

SELECT has_column(       'sales', 'sales_reason', 'sales_reason_id', 'Column sales.sales_reason.sales_reason_id should exist');
SELECT col_type_is(      'sales', 'sales_reason', 'sales_reason_id', 'integer', 'Column sales.sales_reason.sales_reason_id should be type integer');
SELECT col_not_null(     'sales', 'sales_reason', 'sales_reason_id', 'Column sales.sales_reason.sales_reason_id should be NOT NULL');
SELECT col_has_default(  'sales', 'sales_reason', 'sales_reason_id', 'Column sales.sales_reason.sales_reason_id should have a default');
SELECT col_default_is(   'sales', 'sales_reason', 'sales_reason_id', 'nextval(''sales.sales_reason_sales_reason_id_seq''::regclass)', 'Column sales.sales_reason.sales_reason_id default is');

SELECT has_column(       'sales', 'sales_reason', 'name', 'Column sales.sales_reason.name should exist');
SELECT col_type_is(      'sales', 'sales_reason', 'name', 'common.name', 'Column sales.sales_reason.name should be type common.name');
SELECT col_not_null(     'sales', 'sales_reason', 'name', 'Column sales.sales_reason.name should be NOT NULL');
SELECT col_hasnt_default('sales', 'sales_reason', 'name', 'Column sales.sales_reason.name should not have a default');

SELECT has_column(       'sales', 'sales_reason', 'reason_type', 'Column sales.sales_reason.reason_type should exist');
SELECT col_type_is(      'sales', 'sales_reason', 'reason_type', 'common.name', 'Column sales.sales_reason.reason_type should be type common.name');
SELECT col_not_null(     'sales', 'sales_reason', 'reason_type', 'Column sales.sales_reason.reason_type should be NOT NULL');
SELECT col_hasnt_default('sales', 'sales_reason', 'reason_type', 'Column sales.sales_reason.reason_type should not have a default');

SELECT has_column(       'sales', 'sales_reason', 'modified_date', 'Column sales.sales_reason.modified_date should exist');
SELECT col_type_is(      'sales', 'sales_reason', 'modified_date', 'timestamp without time zone', 'Column sales.sales_reason.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'sales', 'sales_reason', 'modified_date', 'Column sales.sales_reason.modified_date should be NOT NULL');
SELECT col_has_default(  'sales', 'sales_reason', 'modified_date', 'Column sales.sales_reason.modified_date should have a default');
SELECT col_default_is(   'sales', 'sales_reason', 'modified_date', 'timezone(''utc''::text, now())', 'Column sales.sales_reason.modified_date default is');

SELECT * FROM finish();
ROLLBACK;

