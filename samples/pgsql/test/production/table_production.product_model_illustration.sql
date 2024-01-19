SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(16);

SELECT has_table(
    'production', 'product_model_illustration',
    'Should have table production.product_model_illustration'
);

SELECT hasnt_pk(
    'production', 'product_model_illustration',
    'Table production.product_model_illustration should have a primary key'
);

SELECT columns_are('production'::name, 'product_model_illustration'::name, ARRAY[
    'product_model_id'::name,
    'illustration_id'::name,
    'modified_date'::name
]);

SELECT has_column(       'production', 'product_model_illustration', 'product_model_id', 'Column production.product_model_illustration.product_model_id should exist');
SELECT col_type_is(      'production', 'product_model_illustration', 'product_model_id', 'integer', 'Column production.product_model_illustration.product_model_id should be type integer');
SELECT col_not_null(     'production', 'product_model_illustration', 'product_model_id', 'Column production.product_model_illustration.product_model_id should be NOT NULL');
SELECT col_hasnt_default('production', 'product_model_illustration', 'product_model_id', 'Column production.product_model_illustration.product_model_id should not have a default');

SELECT has_column(       'production', 'product_model_illustration', 'illustration_id', 'Column production.product_model_illustration.illustration_id should exist');
SELECT col_type_is(      'production', 'product_model_illustration', 'illustration_id', 'integer', 'Column production.product_model_illustration.illustration_id should be type integer');
SELECT col_not_null(     'production', 'product_model_illustration', 'illustration_id', 'Column production.product_model_illustration.illustration_id should be NOT NULL');
SELECT col_hasnt_default('production', 'product_model_illustration', 'illustration_id', 'Column production.product_model_illustration.illustration_id should not have a default');

SELECT has_column(       'production', 'product_model_illustration', 'modified_date', 'Column production.product_model_illustration.modified_date should exist');
SELECT col_type_is(      'production', 'product_model_illustration', 'modified_date', 'timestamp without time zone', 'Column production.product_model_illustration.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'production', 'product_model_illustration', 'modified_date', 'Column production.product_model_illustration.modified_date should be NOT NULL');
SELECT col_has_default(  'production', 'product_model_illustration', 'modified_date', 'Column production.product_model_illustration.modified_date should have a default');
SELECT col_default_is(   'production', 'product_model_illustration', 'modified_date', 'timezone(''utc''::text, now())', 'Column production.product_model_illustration.modified_date default is');

SELECT * FROM finish();
ROLLBACK;
