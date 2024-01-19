SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(21);

SELECT has_table(
    'production', 'product_product_photo',
    'Should have table production.product_product_photo'
);

SELECT hasnt_pk(
    'production', 'product_product_photo',
    'Table production.product_product_photo should have a primary key'
);

SELECT columns_are('production'::name, 'product_product_photo'::name, ARRAY[
    'product_id'::name,
    'product_photo_id'::name,
    'primary'::name,
    'modified_date'::name
]);

SELECT has_column(       'production', 'product_product_photo', 'product_id', 'Column production.product_product_photo.product_id should exist');
SELECT col_type_is(      'production', 'product_product_photo', 'product_id', 'integer', 'Column production.product_product_photo.product_id should be type integer');
SELECT col_not_null(     'production', 'product_product_photo', 'product_id', 'Column production.product_product_photo.product_id should be NOT NULL');
SELECT col_hasnt_default('production', 'product_product_photo', 'product_id', 'Column production.product_product_photo.product_id should not have a default');

SELECT has_column(       'production', 'product_product_photo', 'product_photo_id', 'Column production.product_product_photo.product_photo_id should exist');
SELECT col_type_is(      'production', 'product_product_photo', 'product_photo_id', 'integer', 'Column production.product_product_photo.product_photo_id should be type integer');
SELECT col_not_null(     'production', 'product_product_photo', 'product_photo_id', 'Column production.product_product_photo.product_photo_id should be NOT NULL');
SELECT col_hasnt_default('production', 'product_product_photo', 'product_photo_id', 'Column production.product_product_photo.product_photo_id should not have a default');

SELECT has_column(       'production', 'product_product_photo', 'primary', 'Column production.product_product_photo."primary" should exist');
SELECT col_type_is(      'production', 'product_product_photo', 'primary', 'common.flag', 'Column production.product_product_photo."primary" should be type common.flag');
SELECT col_not_null(     'production', 'product_product_photo', 'primary', 'Column production.product_product_photo."primary" should be NOT NULL');
SELECT col_has_default(  'production', 'product_product_photo', 'primary', 'Column production.product_product_photo."primary" should have a default');
SELECT col_default_is(   'production', 'product_product_photo', 'primary', 'false', 'Column production.product_product_photo."primary" default is');

SELECT has_column(       'production', 'product_product_photo', 'modified_date', 'Column production.product_product_photo.modified_date should exist');
SELECT col_type_is(      'production', 'product_product_photo', 'modified_date', 'timestamp without time zone', 'Column production.product_product_photo.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'production', 'product_product_photo', 'modified_date', 'Column production.product_product_photo.modified_date should be NOT NULL');
SELECT col_has_default(  'production', 'product_product_photo', 'modified_date', 'Column production.product_product_photo.modified_date should have a default');
SELECT col_default_is(   'production', 'product_product_photo', 'modified_date', 'timezone(''utc''::text, now())', 'Column production.product_product_photo.modified_date default is');

SELECT * FROM finish();
ROLLBACK;
