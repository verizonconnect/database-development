SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(34);

SELECT has_table(
    'production', 'product_inventory',
    'Should have table production.product_inventory'
);

SELECT hasnt_pk(
    'production', 'product_inventory',
    'Table production.product_inventory should have a primary key'
);

SELECT columns_are('production'::name, 'product_inventory'::name, ARRAY[
    'product_id'::name,
    'location_id'::name,
    'shelf'::name,
    'bin'::name,
    'quantity'::name,
    'rowguid'::name,
    'modified_date'::name
]);

SELECT has_column(       'production', 'product_inventory', 'product_id', 'Column production.product_inventory.product_id should exist');
SELECT col_type_is(      'production', 'product_inventory', 'product_id', 'integer', 'Column production.product_inventory.product_id should be type integer');
SELECT col_not_null(     'production', 'product_inventory', 'product_id', 'Column production.product_inventory.product_id should be NOT NULL');
SELECT col_hasnt_default('production', 'product_inventory', 'product_id', 'Column production.product_inventory.product_id should not have a default');

SELECT has_column(       'production', 'product_inventory', 'location_id', 'Column production.product_inventory.location_id should exist');
SELECT col_type_is(      'production', 'product_inventory', 'location_id', 'smallint', 'Column production.product_inventory.location_id should be type smallint');
SELECT col_not_null(     'production', 'product_inventory', 'location_id', 'Column production.product_inventory.location_id should be NOT NULL');
SELECT col_hasnt_default('production', 'product_inventory', 'location_id', 'Column production.product_inventory.location_id should not have a default');

SELECT has_column(       'production', 'product_inventory', 'shelf', 'Column production.product_inventory.shelf should exist');
SELECT col_type_is(      'production', 'product_inventory', 'shelf', 'character varying(10)', 'Column production.product_inventory.shelf should be type character varying(10)');
SELECT col_not_null(     'production', 'product_inventory', 'shelf', 'Column production.product_inventory.shelf should be NOT NULL');
SELECT col_hasnt_default('production', 'product_inventory', 'shelf', 'Column production.product_inventory.shelf should not have a default');

SELECT has_column(       'production', 'product_inventory', 'bin', 'Column production.product_inventory.bin should exist');
SELECT col_type_is(      'production', 'product_inventory', 'bin', 'smallint', 'Column production.product_inventory.bin should be type smallint');
SELECT col_not_null(     'production', 'product_inventory', 'bin', 'Column production.product_inventory.bin should be NOT NULL');
SELECT col_hasnt_default('production', 'product_inventory', 'bin', 'Column production.product_inventory.bin should not have a default');

SELECT has_column(       'production', 'product_inventory', 'quantity', 'Column production.product_inventory.quantity should exist');
SELECT col_type_is(      'production', 'product_inventory', 'quantity', 'smallint', 'Column production.product_inventory.quantity should be type smallint');
SELECT col_not_null(     'production', 'product_inventory', 'quantity', 'Column production.product_inventory.quantity should be NOT NULL');
SELECT col_has_default(  'production', 'product_inventory', 'quantity', 'Column production.product_inventory.quantity should have a default');
SELECT col_default_is(   'production', 'product_inventory', 'quantity', '0', 'Column production.product_inventory.quantity default is');

SELECT has_column(       'production', 'product_inventory', 'rowguid', 'Column production.product_inventory.rowguid should exist');
SELECT col_type_is(      'production', 'product_inventory', 'rowguid', 'uuid', 'Column production.product_inventory.rowguid should be type uuid');
SELECT col_not_null(     'production', 'product_inventory', 'rowguid', 'Column production.product_inventory.rowguid should be NOT NULL');
SELECT col_has_default(  'production', 'product_inventory', 'rowguid', 'Column production.product_inventory.rowguid should have a default');
SELECT col_default_is(   'production', 'product_inventory', 'rowguid', 'common.uuid_generate_v1()', 'Column production.product_inventory.rowguid default is');

SELECT has_column(       'production', 'product_inventory', 'modified_date', 'Column production.product_inventory.modified_date should exist');
SELECT col_type_is(      'production', 'product_inventory', 'modified_date', 'timestamp without time zone', 'Column production.product_inventory.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'production', 'product_inventory', 'modified_date', 'Column production.product_inventory.modified_date should be NOT NULL');
SELECT col_has_default(  'production', 'product_inventory', 'modified_date', 'Column production.product_inventory.modified_date should have a default');
SELECT col_default_is(   'production', 'product_inventory', 'modified_date', 'timezone(''utc''::text, now())', 'Column production.product_inventory.modified_date default is');

SELECT * FROM finish();
ROLLBACK;
