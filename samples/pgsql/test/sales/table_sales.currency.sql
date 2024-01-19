SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(16);

SELECT has_table(
    'sales', 'currency',
    'Should have table sales.currency'
);

SELECT hasnt_pk(
    'sales', 'currency',
    'Table sales.currency should have a primary key'
);

SELECT columns_are('sales'::name, 'currency'::name, ARRAY[
    'currency_code'::name,
    'name'::name,
    'modified_date'::name
]);

SELECT has_column(       'sales', 'currency', 'currency_code', 'Column sales.currency.currency_code should exist');
SELECT col_type_is(      'sales', 'currency', 'currency_code', 'character(3)', 'Column sales.currency.currency_code should be type character(3)');
SELECT col_not_null(     'sales', 'currency', 'currency_code', 'Column sales.currency.currency_code should be NOT NULL');
SELECT col_hasnt_default('sales', 'currency', 'currency_code', 'Column sales.currency.currency_code should not have a default');

SELECT has_column(       'sales', 'currency', 'name', 'Column sales.currency.name should exist');
SELECT col_type_is(      'sales', 'currency', 'name', 'common.name', 'Column sales.currency.name should be type common.name');
SELECT col_not_null(     'sales', 'currency', 'name', 'Column sales.currency.name should be NOT NULL');
SELECT col_hasnt_default('sales', 'currency', 'name', 'Column sales.currency.name should not have a default');

SELECT has_column(       'sales', 'currency', 'modified_date', 'Column sales.currency.modified_date should exist');
SELECT col_type_is(      'sales', 'currency', 'modified_date', 'timestamp without time zone', 'Column sales.currency.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'sales', 'currency', 'modified_date', 'Column sales.currency.modified_date should be NOT NULL');
SELECT col_has_default(  'sales', 'currency', 'modified_date', 'Column sales.currency.modified_date should have a default');
SELECT col_default_is(   'sales', 'currency', 'modified_date', 'timezone(''utc''::text, now())', 'Column sales.currency.modified_date default is');

SELECT * FROM finish();
ROLLBACK;
