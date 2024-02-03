SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(23);

SELECT has_table(
    'production', 'product_category',
    'Should have table production.product_category'
);

SELECT has_pk(
    'production', 'product_category',
    'Table production.product_category should have a primary key'
);

SELECT col_is_pk('production'::name, 'product_category'::name, ARRAY[
    'product_category_id'::name
],
'Primary key definition is not as expected');

SELECT columns_are('production'::name, 'product_category'::name, ARRAY[
    'product_category_id'::name,
    'name'::name,
    'rowguid'::name,
    'modified_date'::name
]);

SELECT has_column(       'production', 'product_category', 'product_category_id', 'Column production.product_category.product_category_id should exist');
SELECT col_type_is(      'production', 'product_category', 'product_category_id', 'integer', 'Column production.product_category.product_category_id should be type integer');
SELECT col_not_null(     'production', 'product_category', 'product_category_id', 'Column production.product_category.product_category_id should be NOT NULL');
SELECT col_has_default(  'production', 'product_category', 'product_category_id', 'Column production.product_category.product_category_id should have a default');
SELECT col_default_is(   'production', 'product_category', 'product_category_id', 'nextval(''production.product_category_product_category_id_seq''::regclass)', 'Column production.product_category.product_category_id default is');

SELECT has_column(       'production', 'product_category', 'name', 'Column production.product_category.name should exist');
SELECT col_type_is(      'production', 'product_category', 'name', 'common.name', 'Column production.product_category.name should be type common.name');
SELECT col_not_null(     'production', 'product_category', 'name', 'Column production.product_category.name should be NOT NULL');
SELECT col_hasnt_default('production', 'product_category', 'name', 'Column production.product_category.name should not have a default');

SELECT has_column(       'production', 'product_category', 'rowguid', 'Column production.product_category.rowguid should exist');
SELECT col_type_is(      'production', 'product_category', 'rowguid', 'uuid', 'Column production.product_category.rowguid should be type uuid');
SELECT col_not_null(     'production', 'product_category', 'rowguid', 'Column production.product_category.rowguid should be NOT NULL');
SELECT col_has_default(  'production', 'product_category', 'rowguid', 'Column production.product_category.rowguid should have a default');
SELECT col_default_is(   'production', 'product_category', 'rowguid', 'common.uuid_generate_v1()', 'Column production.product_category.rowguid default is');

SELECT has_column(       'production', 'product_category', 'modified_date', 'Column production.product_category.modified_date should exist');
SELECT col_type_is(      'production', 'product_category', 'modified_date', 'timestamp without time zone', 'Column production.product_category.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'production', 'product_category', 'modified_date', 'Column production.product_category.modified_date should be NOT NULL');
SELECT col_has_default(  'production', 'product_category', 'modified_date', 'Column production.product_category.modified_date should have a default');
SELECT col_default_is(   'production', 'product_category', 'modified_date', 'timezone(''utc''::text, now())', 'Column production.product_category.modified_date default is');

SELECT * FROM finish();
ROLLBACK;

