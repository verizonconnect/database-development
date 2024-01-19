SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(29);

SELECT has_table(
    'production', 'product_photo',
    'Should have table production.product_photo'
);

SELECT hasnt_pk(
    'production', 'product_photo',
    'Table production.product_photo should have a primary key'
);

SELECT columns_are('production'::name, 'product_photo'::name, ARRAY[
    'product_photo_id'::name,
    'thumb_nail_photo'::name,
    'thumb_nail_photo_file_name'::name,
    'large_photo'::name,
    'large_photo_file_name'::name,
    'modified_date'::name
]);

SELECT has_column(       'production', 'product_photo', 'product_photo_id', 'Column production.product_photo.product_photo_id should exist');
SELECT col_type_is(      'production', 'product_photo', 'product_photo_id', 'integer', 'Column production.product_photo.product_photo_id should be type integer');
SELECT col_not_null(     'production', 'product_photo', 'product_photo_id', 'Column production.product_photo.product_photo_id should be NOT NULL');
SELECT col_has_default(  'production', 'product_photo', 'product_photo_id', 'Column production.product_photo.product_photo_id should have a default');
SELECT col_default_is(   'production', 'product_photo', 'product_photo_id', 'nextval(''production.product_photo_product_photo_id_seq''::regclass)', 'Column production.product_photo.product_photo_id default is');

SELECT has_column(       'production', 'product_photo', 'thumb_nail_photo', 'Column production.product_photo.thumb_nail_photo should exist');
SELECT col_type_is(      'production', 'product_photo', 'thumb_nail_photo', 'bytea', 'Column production.product_photo.thumb_nail_photo should be type bytea');
SELECT col_is_null(      'production', 'product_photo', 'thumb_nail_photo', 'Column production.product_photo.thumb_nail_photo should allow NULL');
SELECT col_hasnt_default('production', 'product_photo', 'thumb_nail_photo', 'Column production.product_photo.thumb_nail_photo should not have a default');

SELECT has_column(       'production', 'product_photo', 'thumb_nail_photo_file_name', 'Column production.product_photo.thumb_nail_photo_file_name should exist');
SELECT col_type_is(      'production', 'product_photo', 'thumb_nail_photo_file_name', 'character varying(50)', 'Column production.product_photo.thumb_nail_photo_file_name should be type character varying(50)');
SELECT col_is_null(      'production', 'product_photo', 'thumb_nail_photo_file_name', 'Column production.product_photo.thumb_nail_photo_file_name should allow NULL');
SELECT col_hasnt_default('production', 'product_photo', 'thumb_nail_photo_file_name', 'Column production.product_photo.thumb_nail_photo_file_name should not have a default');

SELECT has_column(       'production', 'product_photo', 'large_photo', 'Column production.product_photo.large_photo should exist');
SELECT col_type_is(      'production', 'product_photo', 'large_photo', 'bytea', 'Column production.product_photo.large_photo should be type bytea');
SELECT col_is_null(      'production', 'product_photo', 'large_photo', 'Column production.product_photo.large_photo should allow NULL');
SELECT col_hasnt_default('production', 'product_photo', 'large_photo', 'Column production.product_photo.large_photo should not have a default');

SELECT has_column(       'production', 'product_photo', 'large_photo_file_name', 'Column production.product_photo.large_photo_file_name should exist');
SELECT col_type_is(      'production', 'product_photo', 'large_photo_file_name', 'character varying(50)', 'Column production.product_photo.large_photo_file_name should be type character varying(50)');
SELECT col_is_null(      'production', 'product_photo', 'large_photo_file_name', 'Column production.product_photo.large_photo_file_name should allow NULL');
SELECT col_hasnt_default('production', 'product_photo', 'large_photo_file_name', 'Column production.product_photo.large_photo_file_name should not have a default');

SELECT has_column(       'production', 'product_photo', 'modified_date', 'Column production.product_photo.modified_date should exist');
SELECT col_type_is(      'production', 'product_photo', 'modified_date', 'timestamp without time zone', 'Column production.product_photo.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'production', 'product_photo', 'modified_date', 'Column production.product_photo.modified_date should be NOT NULL');
SELECT col_has_default(  'production', 'product_photo', 'modified_date', 'Column production.product_photo.modified_date should have a default');
SELECT col_default_is(   'production', 'product_photo', 'modified_date', 'timezone(''utc''::text, now())', 'Column production.product_photo.modified_date default is');

SELECT * FROM finish();
ROLLBACK;
