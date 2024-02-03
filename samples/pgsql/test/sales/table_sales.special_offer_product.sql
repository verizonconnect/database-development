SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(22);

SELECT has_table(
    'sales', 'special_offer_product',
    'Should have table sales.special_offer_product'
);

SELECT has_pk(
    'sales', 'special_offer_product',
    'Table sales.special_offer_product should have a primary key'
);

SELECT col_is_pk('sales'::name, 'special_offer_product'::name, ARRAY[
    'special_offer_id'::name,
    'product_id'::name
],
'Primary key definition is not as expected');

SELECT columns_are('sales'::name, 'special_offer_product'::name, ARRAY[
    'special_offer_id'::name,
    'product_id'::name,
    'rowguid'::name,
    'modified_date'::name
]);

SELECT has_column(       'sales', 'special_offer_product', 'special_offer_id', 'Column sales.special_offer_product.special_offer_id should exist');
SELECT col_type_is(      'sales', 'special_offer_product', 'special_offer_id', 'integer', 'Column sales.special_offer_product.special_offer_id should be type integer');
SELECT col_not_null(     'sales', 'special_offer_product', 'special_offer_id', 'Column sales.special_offer_product.special_offer_id should be NOT NULL');
SELECT col_hasnt_default('sales', 'special_offer_product', 'special_offer_id', 'Column sales.special_offer_product.special_offer_id should not have a default');

SELECT has_column(       'sales', 'special_offer_product', 'product_id', 'Column sales.special_offer_product.product_id should exist');
SELECT col_type_is(      'sales', 'special_offer_product', 'product_id', 'integer', 'Column sales.special_offer_product.product_id should be type integer');
SELECT col_not_null(     'sales', 'special_offer_product', 'product_id', 'Column sales.special_offer_product.product_id should be NOT NULL');
SELECT col_hasnt_default('sales', 'special_offer_product', 'product_id', 'Column sales.special_offer_product.product_id should not have a default');

SELECT has_column(       'sales', 'special_offer_product', 'rowguid', 'Column sales.special_offer_product.rowguid should exist');
SELECT col_type_is(      'sales', 'special_offer_product', 'rowguid', 'uuid', 'Column sales.special_offer_product.rowguid should be type uuid');
SELECT col_not_null(     'sales', 'special_offer_product', 'rowguid', 'Column sales.special_offer_product.rowguid should be NOT NULL');
SELECT col_has_default(  'sales', 'special_offer_product', 'rowguid', 'Column sales.special_offer_product.rowguid should have a default');
SELECT col_default_is(   'sales', 'special_offer_product', 'rowguid', 'common.uuid_generate_v1()', 'Column sales.special_offer_product.rowguid default is');

SELECT has_column(       'sales', 'special_offer_product', 'modified_date', 'Column sales.special_offer_product.modified_date should exist');
SELECT col_type_is(      'sales', 'special_offer_product', 'modified_date', 'timestamp without time zone', 'Column sales.special_offer_product.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'sales', 'special_offer_product', 'modified_date', 'Column sales.special_offer_product.modified_date should be NOT NULL');
SELECT col_has_default(  'sales', 'special_offer_product', 'modified_date', 'Column sales.special_offer_product.modified_date should have a default');
SELECT col_default_is(   'sales', 'special_offer_product', 'modified_date', 'timezone(''utc''::text, now())', 'Column sales.special_offer_product.modified_date default is');

SELECT * FROM finish();
ROLLBACK;

