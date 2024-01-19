SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(33);

SELECT has_table(
    'sales', 'currency_rate',
    'Should have table sales.currency_rate'
);

SELECT hasnt_pk(
    'sales', 'currency_rate',
    'Table sales.currency_rate should have a primary key'
);

SELECT columns_are('sales'::name, 'currency_rate'::name, ARRAY[
    'currency_rate_id'::name,
    'currency_rate_date'::name,
    'from_currency_code'::name,
    'to_currency_code'::name,
    'average_rate'::name,
    'end_of_day_rate'::name,
    'modified_date'::name
]);

SELECT has_column(       'sales', 'currency_rate', 'currency_rate_id', 'Column sales.currency_rate.currency_rate_id should exist');
SELECT col_type_is(      'sales', 'currency_rate', 'currency_rate_id', 'integer', 'Column sales.currency_rate.currency_rate_id should be type integer');
SELECT col_not_null(     'sales', 'currency_rate', 'currency_rate_id', 'Column sales.currency_rate.currency_rate_id should be NOT NULL');
SELECT col_has_default(  'sales', 'currency_rate', 'currency_rate_id', 'Column sales.currency_rate.currency_rate_id should have a default');
SELECT col_default_is(   'sales', 'currency_rate', 'currency_rate_id', 'nextval(''sales.currency_rate_currency_rate_id_seq''::regclass)', 'Column sales.currency_rate.currency_rate_id default is');

SELECT has_column(       'sales', 'currency_rate', 'currency_rate_date', 'Column sales.currency_rate.currency_rate_date should exist');
SELECT col_type_is(      'sales', 'currency_rate', 'currency_rate_date', 'timestamp without time zone', 'Column sales.currency_rate.currency_rate_date should be type timestamp without time zone');
SELECT col_not_null(     'sales', 'currency_rate', 'currency_rate_date', 'Column sales.currency_rate.currency_rate_date should be NOT NULL');
SELECT col_hasnt_default('sales', 'currency_rate', 'currency_rate_date', 'Column sales.currency_rate.currency_rate_date should not have a default');

SELECT has_column(       'sales', 'currency_rate', 'from_currency_code', 'Column sales.currency_rate.from_currency_code should exist');
SELECT col_type_is(      'sales', 'currency_rate', 'from_currency_code', 'character(3)', 'Column sales.currency_rate.from_currency_code should be type character(3)');
SELECT col_not_null(     'sales', 'currency_rate', 'from_currency_code', 'Column sales.currency_rate.from_currency_code should be NOT NULL');
SELECT col_hasnt_default('sales', 'currency_rate', 'from_currency_code', 'Column sales.currency_rate.from_currency_code should not have a default');

SELECT has_column(       'sales', 'currency_rate', 'to_currency_code', 'Column sales.currency_rate.to_currency_code should exist');
SELECT col_type_is(      'sales', 'currency_rate', 'to_currency_code', 'character(3)', 'Column sales.currency_rate.to_currency_code should be type character(3)');
SELECT col_not_null(     'sales', 'currency_rate', 'to_currency_code', 'Column sales.currency_rate.to_currency_code should be NOT NULL');
SELECT col_hasnt_default('sales', 'currency_rate', 'to_currency_code', 'Column sales.currency_rate.to_currency_code should not have a default');

SELECT has_column(       'sales', 'currency_rate', 'average_rate', 'Column sales.currency_rate.average_rate should exist');
SELECT col_type_is(      'sales', 'currency_rate', 'average_rate', 'numeric', 'Column sales.currency_rate.average_rate should be type numeric');
SELECT col_not_null(     'sales', 'currency_rate', 'average_rate', 'Column sales.currency_rate.average_rate should be NOT NULL');
SELECT col_hasnt_default('sales', 'currency_rate', 'average_rate', 'Column sales.currency_rate.average_rate should not have a default');

SELECT has_column(       'sales', 'currency_rate', 'end_of_day_rate', 'Column sales.currency_rate.end_of_day_rate should exist');
SELECT col_type_is(      'sales', 'currency_rate', 'end_of_day_rate', 'numeric', 'Column sales.currency_rate.end_of_day_rate should be type numeric');
SELECT col_not_null(     'sales', 'currency_rate', 'end_of_day_rate', 'Column sales.currency_rate.end_of_day_rate should be NOT NULL');
SELECT col_hasnt_default('sales', 'currency_rate', 'end_of_day_rate', 'Column sales.currency_rate.end_of_day_rate should not have a default');

SELECT has_column(       'sales', 'currency_rate', 'modified_date', 'Column sales.currency_rate.modified_date should exist');
SELECT col_type_is(      'sales', 'currency_rate', 'modified_date', 'timestamp without time zone', 'Column sales.currency_rate.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'sales', 'currency_rate', 'modified_date', 'Column sales.currency_rate.modified_date should be NOT NULL');
SELECT col_has_default(  'sales', 'currency_rate', 'modified_date', 'Column sales.currency_rate.modified_date should have a default');
SELECT col_default_is(   'sales', 'currency_rate', 'modified_date', 'timezone(''utc''::text, now())', 'Column sales.currency_rate.modified_date default is');

SELECT * FROM finish();
ROLLBACK;
