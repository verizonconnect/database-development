SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(23);

SELECT has_table(
    'production', 'product_description',
    'Should have table production.product_description'
);

SELECT has_pk(
    'production', 'product_description',
    'Table production.product_description should have a primary key'
);

SELECT col_is_pk('production'::name, 'product_description'::name, ARRAY[
    'product_description_id'::name
],
'Primary key definition is not as expected');

SELECT columns_are('production'::name, 'product_description'::name, ARRAY[
    'product_description_id'::name,
    'description'::name,
    'rowguid'::name,
    'modified_date'::name
]);

SELECT has_column(       'production', 'product_description', 'product_description_id', 'Column production.product_description.product_description_id should exist');
SELECT col_type_is(      'production', 'product_description', 'product_description_id', 'integer', 'Column production.product_description.product_description_id should be type integer');
SELECT col_not_null(     'production', 'product_description', 'product_description_id', 'Column production.product_description.product_description_id should be NOT NULL');
SELECT col_has_default(  'production', 'product_description', 'product_description_id', 'Column production.product_description.product_description_id should have a default');
SELECT col_default_is(   'production', 'product_description', 'product_description_id', 'nextval(''production.product_description_product_description_id_seq''::regclass)', 'Column production.product_description.product_description_id default is');

SELECT has_column(       'production', 'product_description', 'description', 'Column production.product_description.description should exist');
SELECT col_type_is(      'production', 'product_description', 'description', 'character varying(400)', 'Column production.product_description.description should be type character varying(400)');
SELECT col_not_null(     'production', 'product_description', 'description', 'Column production.product_description.description should be NOT NULL');
SELECT col_hasnt_default('production', 'product_description', 'description', 'Column production.product_description.description should not have a default');

SELECT has_column(       'production', 'product_description', 'rowguid', 'Column production.product_description.rowguid should exist');
SELECT col_type_is(      'production', 'product_description', 'rowguid', 'uuid', 'Column production.product_description.rowguid should be type uuid');
SELECT col_not_null(     'production', 'product_description', 'rowguid', 'Column production.product_description.rowguid should be NOT NULL');
SELECT col_has_default(  'production', 'product_description', 'rowguid', 'Column production.product_description.rowguid should have a default');
SELECT col_default_is(   'production', 'product_description', 'rowguid', 'common.uuid_generate_v1()', 'Column production.product_description.rowguid default is');

SELECT has_column(       'production', 'product_description', 'modified_date', 'Column production.product_description.modified_date should exist');
SELECT col_type_is(      'production', 'product_description', 'modified_date', 'timestamp without time zone', 'Column production.product_description.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'production', 'product_description', 'modified_date', 'Column production.product_description.modified_date should be NOT NULL');
SELECT col_has_default(  'production', 'product_description', 'modified_date', 'Column production.product_description.modified_date should have a default');
SELECT col_default_is(   'production', 'product_description', 'modified_date', 'timezone(''utc''::text, now())', 'Column production.product_description.modified_date default is');

SELECT * FROM finish();
ROLLBACK;

