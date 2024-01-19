SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(16);

SELECT has_table(
    'sales', 'country_region_currency',
    'Should have table sales.country_region_currency'
);

SELECT hasnt_pk(
    'sales', 'country_region_currency',
    'Table sales.country_region_currency should have a primary key'
);

SELECT columns_are('sales'::name, 'country_region_currency'::name, ARRAY[
    'country_region_code'::name,
    'currency_code'::name,
    'modified_date'::name
]);

SELECT has_column(       'sales', 'country_region_currency', 'country_region_code', 'Column sales.country_region_currency.country_region_code should exist');
SELECT col_type_is(      'sales', 'country_region_currency', 'country_region_code', 'character(3)', 'Column sales.country_region_currency.country_region_code should be type character(3)');
SELECT col_not_null(     'sales', 'country_region_currency', 'country_region_code', 'Column sales.country_region_currency.country_region_code should be NOT NULL');
SELECT col_hasnt_default('sales', 'country_region_currency', 'country_region_code', 'Column sales.country_region_currency.country_region_code should not have a default');

SELECT has_column(       'sales', 'country_region_currency', 'currency_code', 'Column sales.country_region_currency.currency_code should exist');
SELECT col_type_is(      'sales', 'country_region_currency', 'currency_code', 'character(3)', 'Column sales.country_region_currency.currency_code should be type character(3)');
SELECT col_not_null(     'sales', 'country_region_currency', 'currency_code', 'Column sales.country_region_currency.currency_code should be NOT NULL');
SELECT col_hasnt_default('sales', 'country_region_currency', 'currency_code', 'Column sales.country_region_currency.currency_code should not have a default');

SELECT has_column(       'sales', 'country_region_currency', 'modified_date', 'Column sales.country_region_currency.modified_date should exist');
SELECT col_type_is(      'sales', 'country_region_currency', 'modified_date', 'timestamp without time zone', 'Column sales.country_region_currency.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'sales', 'country_region_currency', 'modified_date', 'Column sales.country_region_currency.modified_date should be NOT NULL');
SELECT col_has_default(  'sales', 'country_region_currency', 'modified_date', 'Column sales.country_region_currency.modified_date should have a default');
SELECT col_default_is(   'sales', 'country_region_currency', 'modified_date', 'timezone(''utc''::text, now())', 'Column sales.country_region_currency.modified_date default is');

SELECT * FROM finish();
ROLLBACK;
