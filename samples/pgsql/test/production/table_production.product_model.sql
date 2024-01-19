SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(30);

SELECT has_table(
    'production', 'product_model',
    'Should have table production.product_model'
);

SELECT hasnt_pk(
    'production', 'product_model',
    'Table production.product_model should have a primary key'
);

SELECT columns_are('production'::name, 'product_model'::name, ARRAY[
    'product_model_id'::name,
    'name'::name,
    'catalog_description'::name,
    'instructions'::name,
    'rowguid'::name,
    'modified_date'::name
]);

SELECT has_column(       'production', 'product_model', 'product_model_id', 'Column production.product_model.product_model_id should exist');
SELECT col_type_is(      'production', 'product_model', 'product_model_id', 'integer', 'Column production.product_model.product_model_id should be type integer');
SELECT col_not_null(     'production', 'product_model', 'product_model_id', 'Column production.product_model.product_model_id should be NOT NULL');
SELECT col_has_default(  'production', 'product_model', 'product_model_id', 'Column production.product_model.product_model_id should have a default');
SELECT col_default_is(   'production', 'product_model', 'product_model_id', 'nextval(''production.product_model_product_model_id_seq''::regclass)', 'Column production.product_model.product_model_id default is');

SELECT has_column(       'production', 'product_model', 'name', 'Column production.product_model.name should exist');
SELECT col_type_is(      'production', 'product_model', 'name', 'common.name', 'Column production.product_model.name should be type common.name');
SELECT col_not_null(     'production', 'product_model', 'name', 'Column production.product_model.name should be NOT NULL');
SELECT col_hasnt_default('production', 'product_model', 'name', 'Column production.product_model.name should not have a default');

SELECT has_column(       'production', 'product_model', 'catalog_description', 'Column production.product_model.catalog_description should exist');
SELECT col_type_is(      'production', 'product_model', 'catalog_description', 'xml', 'Column production.product_model.catalog_description should be type xml');
SELECT col_is_null(      'production', 'product_model', 'catalog_description', 'Column production.product_model.catalog_description should allow NULL');
SELECT col_hasnt_default('production', 'product_model', 'catalog_description', 'Column production.product_model.catalog_description should not have a default');

SELECT has_column(       'production', 'product_model', 'instructions', 'Column production.product_model.instructions should exist');
SELECT col_type_is(      'production', 'product_model', 'instructions', 'xml', 'Column production.product_model.instructions should be type xml');
SELECT col_is_null(      'production', 'product_model', 'instructions', 'Column production.product_model.instructions should allow NULL');
SELECT col_hasnt_default('production', 'product_model', 'instructions', 'Column production.product_model.instructions should not have a default');

SELECT has_column(       'production', 'product_model', 'rowguid', 'Column production.product_model.rowguid should exist');
SELECT col_type_is(      'production', 'product_model', 'rowguid', 'uuid', 'Column production.product_model.rowguid should be type uuid');
SELECT col_not_null(     'production', 'product_model', 'rowguid', 'Column production.product_model.rowguid should be NOT NULL');
SELECT col_has_default(  'production', 'product_model', 'rowguid', 'Column production.product_model.rowguid should have a default');
SELECT col_default_is(   'production', 'product_model', 'rowguid', 'common.uuid_generate_v1()', 'Column production.product_model.rowguid default is');

SELECT has_column(       'production', 'product_model', 'modified_date', 'Column production.product_model.modified_date should exist');
SELECT col_type_is(      'production', 'product_model', 'modified_date', 'timestamp without time zone', 'Column production.product_model.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'production', 'product_model', 'modified_date', 'Column production.product_model.modified_date should be NOT NULL');
SELECT col_has_default(  'production', 'product_model', 'modified_date', 'Column production.product_model.modified_date should have a default');
SELECT col_default_is(   'production', 'product_model', 'modified_date', 'timezone(''utc''::text, now())', 'Column production.product_model.modified_date default is');

SELECT * FROM finish();
ROLLBACK;
