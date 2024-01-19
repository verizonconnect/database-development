SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(35);

SELECT has_table(
    'sales', 'sales_tax_rate',
    'Should have table sales.sales_tax_rate'
);

SELECT hasnt_pk(
    'sales', 'sales_tax_rate',
    'Table sales.sales_tax_rate should have a primary key'
);

SELECT columns_are('sales'::name, 'sales_tax_rate'::name, ARRAY[
    'sales_tax_rate_id'::name,
    'state_province_id'::name,
    'tax_type'::name,
    'tax_rate'::name,
    'name'::name,
    'rowguid'::name,
    'modified_date'::name
]);

SELECT has_column(       'sales', 'sales_tax_rate', 'sales_tax_rate_id', 'Column sales.sales_tax_rate.sales_tax_rate_id should exist');
SELECT col_type_is(      'sales', 'sales_tax_rate', 'sales_tax_rate_id', 'integer', 'Column sales.sales_tax_rate.sales_tax_rate_id should be type integer');
SELECT col_not_null(     'sales', 'sales_tax_rate', 'sales_tax_rate_id', 'Column sales.sales_tax_rate.sales_tax_rate_id should be NOT NULL');
SELECT col_has_default(  'sales', 'sales_tax_rate', 'sales_tax_rate_id', 'Column sales.sales_tax_rate.sales_tax_rate_id should have a default');
SELECT col_default_is(   'sales', 'sales_tax_rate', 'sales_tax_rate_id', 'nextval(''sales.sales_tax_rate_sales_tax_rate_id_seq''::regclass)', 'Column sales.sales_tax_rate.sales_tax_rate_id default is');

SELECT has_column(       'sales', 'sales_tax_rate', 'state_province_id', 'Column sales.sales_tax_rate.state_province_id should exist');
SELECT col_type_is(      'sales', 'sales_tax_rate', 'state_province_id', 'integer', 'Column sales.sales_tax_rate.state_province_id should be type integer');
SELECT col_not_null(     'sales', 'sales_tax_rate', 'state_province_id', 'Column sales.sales_tax_rate.state_province_id should be NOT NULL');
SELECT col_hasnt_default('sales', 'sales_tax_rate', 'state_province_id', 'Column sales.sales_tax_rate.state_province_id should not have a default');

SELECT has_column(       'sales', 'sales_tax_rate', 'tax_type', 'Column sales.sales_tax_rate.tax_type should exist');
SELECT col_type_is(      'sales', 'sales_tax_rate', 'tax_type', 'smallint', 'Column sales.sales_tax_rate.tax_type should be type smallint');
SELECT col_not_null(     'sales', 'sales_tax_rate', 'tax_type', 'Column sales.sales_tax_rate.tax_type should be NOT NULL');
SELECT col_hasnt_default('sales', 'sales_tax_rate', 'tax_type', 'Column sales.sales_tax_rate.tax_type should not have a default');

SELECT has_column(       'sales', 'sales_tax_rate', 'tax_rate', 'Column sales.sales_tax_rate.tax_rate should exist');
SELECT col_type_is(      'sales', 'sales_tax_rate', 'tax_rate', 'numeric', 'Column sales.sales_tax_rate.tax_rate should be type numeric');
SELECT col_not_null(     'sales', 'sales_tax_rate', 'tax_rate', 'Column sales.sales_tax_rate.tax_rate should be NOT NULL');
SELECT col_has_default(  'sales', 'sales_tax_rate', 'tax_rate', 'Column sales.sales_tax_rate.tax_rate should have a default');
SELECT col_default_is(   'sales', 'sales_tax_rate', 'tax_rate', '0.00', 'Column sales.sales_tax_rate.tax_rate default is');

SELECT has_column(       'sales', 'sales_tax_rate', 'name', 'Column sales.sales_tax_rate.name should exist');
SELECT col_type_is(      'sales', 'sales_tax_rate', 'name', 'common.name', 'Column sales.sales_tax_rate.name should be type common.name');
SELECT col_not_null(     'sales', 'sales_tax_rate', 'name', 'Column sales.sales_tax_rate.name should be NOT NULL');
SELECT col_hasnt_default('sales', 'sales_tax_rate', 'name', 'Column sales.sales_tax_rate.name should not have a default');

SELECT has_column(       'sales', 'sales_tax_rate', 'rowguid', 'Column sales.sales_tax_rate.rowguid should exist');
SELECT col_type_is(      'sales', 'sales_tax_rate', 'rowguid', 'uuid', 'Column sales.sales_tax_rate.rowguid should be type uuid');
SELECT col_not_null(     'sales', 'sales_tax_rate', 'rowguid', 'Column sales.sales_tax_rate.rowguid should be NOT NULL');
SELECT col_has_default(  'sales', 'sales_tax_rate', 'rowguid', 'Column sales.sales_tax_rate.rowguid should have a default');
SELECT col_default_is(   'sales', 'sales_tax_rate', 'rowguid', 'common.uuid_generate_v1()', 'Column sales.sales_tax_rate.rowguid default is');

SELECT has_column(       'sales', 'sales_tax_rate', 'modified_date', 'Column sales.sales_tax_rate.modified_date should exist');
SELECT col_type_is(      'sales', 'sales_tax_rate', 'modified_date', 'timestamp without time zone', 'Column sales.sales_tax_rate.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'sales', 'sales_tax_rate', 'modified_date', 'Column sales.sales_tax_rate.modified_date should be NOT NULL');
SELECT col_has_default(  'sales', 'sales_tax_rate', 'modified_date', 'Column sales.sales_tax_rate.modified_date should have a default');
SELECT col_default_is(   'sales', 'sales_tax_rate', 'modified_date', 'timezone(''utc''::text, now())', 'Column sales.sales_tax_rate.modified_date default is');

SELECT * FROM finish();
ROLLBACK;
