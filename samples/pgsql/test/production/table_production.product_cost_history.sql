SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(28);

SELECT has_table(
    'production', 'product_cost_history',
    'Should have table production.product_cost_history'
);

SELECT has_pk(
    'production', 'product_cost_history',
    'Table production.product_cost_history should have a primary key'
);

SELECT has_check(
    'production', 'product_cost_history',
    'Table production.product_cost_history should have check contraint(s)'
);

SELECT col_is_pk('production'::name, 'product_cost_history'::name, ARRAY[
    'product_id'::name,
    'start_date'::name
],
'Primary key definition is not as expected');

SELECT columns_are('production'::name, 'product_cost_history'::name, ARRAY[
    'product_id'::name,
    'start_date'::name,
    'end_date'::name,
    'standard_cost'::name,
    'modified_date'::name
]);

SELECT has_column(       'production', 'product_cost_history', 'product_id', 'Column production.product_cost_history.product_id should exist');
SELECT col_type_is(      'production', 'product_cost_history', 'product_id', 'integer', 'Column production.product_cost_history.product_id should be type integer');
SELECT col_not_null(     'production', 'product_cost_history', 'product_id', 'Column production.product_cost_history.product_id should be NOT NULL');
SELECT col_hasnt_default('production', 'product_cost_history', 'product_id', 'Column production.product_cost_history.product_id should not have a default');

SELECT has_column(       'production', 'product_cost_history', 'start_date', 'Column production.product_cost_history.start_date should exist');
SELECT col_type_is(      'production', 'product_cost_history', 'start_date', 'timestamp without time zone', 'Column production.product_cost_history.start_date should be type timestamp without time zone');
SELECT col_not_null(     'production', 'product_cost_history', 'start_date', 'Column production.product_cost_history.start_date should be NOT NULL');
SELECT col_hasnt_default('production', 'product_cost_history', 'start_date', 'Column production.product_cost_history.start_date should not have a default');

SELECT has_column(       'production', 'product_cost_history', 'end_date', 'Column production.product_cost_history.end_date should exist');
SELECT col_type_is(      'production', 'product_cost_history', 'end_date', 'timestamp without time zone', 'Column production.product_cost_history.end_date should be type timestamp without time zone');
SELECT col_is_null(      'production', 'product_cost_history', 'end_date', 'Column production.product_cost_history.end_date should allow NULL');
SELECT col_hasnt_default('production', 'product_cost_history', 'end_date', 'Column production.product_cost_history.end_date should not have a default');
SELECT col_has_check(    'production', 'product_cost_history', ARRAY['end_date'::name,'start_date'::name], 'Columns production.product_cost_history.[end_date,start_date] should have a check constraint');

SELECT has_column(       'production', 'product_cost_history', 'standard_cost', 'Column production.product_cost_history.standard_cost should exist');
SELECT col_type_is(      'production', 'product_cost_history', 'standard_cost', 'numeric', 'Column production.product_cost_history.standard_cost should be type numeric');
SELECT col_not_null(     'production', 'product_cost_history', 'standard_cost', 'Column production.product_cost_history.standard_cost should be NOT NULL');
SELECT col_hasnt_default('production', 'product_cost_history', 'standard_cost', 'Column production.product_cost_history.standard_cost should not have a default');
SELECT col_has_check(    'production', 'product_cost_history', 'standard_cost', 'Column production.product_cost_history.standard_cost should have a check constraint');

SELECT has_column(       'production', 'product_cost_history', 'modified_date', 'Column production.product_cost_history.modified_date should exist');
SELECT col_type_is(      'production', 'product_cost_history', 'modified_date', 'timestamp without time zone', 'Column production.product_cost_history.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'production', 'product_cost_history', 'modified_date', 'Column production.product_cost_history.modified_date should be NOT NULL');
SELECT col_has_default(  'production', 'product_cost_history', 'modified_date', 'Column production.product_cost_history.modified_date should have a default');
SELECT col_default_is(   'production', 'product_cost_history', 'modified_date', 'timezone(''utc''::text, now())', 'Column production.product_cost_history.modified_date default is');

SELECT * FROM finish();
ROLLBACK;

