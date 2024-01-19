SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(32);

SELECT has_table(
    'purchasing', 'ship_method',
    'Should have table purchasing.ship_method'
);

SELECT hasnt_pk(
    'purchasing', 'ship_method',
    'Table purchasing.ship_method should have a primary key'
);

SELECT columns_are('purchasing'::name, 'ship_method'::name, ARRAY[
    'ship_method_id'::name,
    'name'::name,
    'ship_base'::name,
    'ship_rate'::name,
    'rowguid'::name,
    'modified_date'::name
]);

SELECT has_column(       'purchasing', 'ship_method', 'ship_method_id', 'Column purchasing.ship_method.ship_method_id should exist');
SELECT col_type_is(      'purchasing', 'ship_method', 'ship_method_id', 'integer', 'Column purchasing.ship_method.ship_method_id should be type integer');
SELECT col_not_null(     'purchasing', 'ship_method', 'ship_method_id', 'Column purchasing.ship_method.ship_method_id should be NOT NULL');
SELECT col_has_default(  'purchasing', 'ship_method', 'ship_method_id', 'Column purchasing.ship_method.ship_method_id should have a default');
SELECT col_default_is(   'purchasing', 'ship_method', 'ship_method_id', 'nextval(''purchasing.ship_method_ship_method_id_seq''::regclass)', 'Column purchasing.ship_method.ship_method_id default is');

SELECT has_column(       'purchasing', 'ship_method', 'name', 'Column purchasing.ship_method.name should exist');
SELECT col_type_is(      'purchasing', 'ship_method', 'name', 'common.name', 'Column purchasing.ship_method.name should be type common.name');
SELECT col_not_null(     'purchasing', 'ship_method', 'name', 'Column purchasing.ship_method.name should be NOT NULL');
SELECT col_hasnt_default('purchasing', 'ship_method', 'name', 'Column purchasing.ship_method.name should not have a default');

SELECT has_column(       'purchasing', 'ship_method', 'ship_base', 'Column purchasing.ship_method.ship_base should exist');
SELECT col_type_is(      'purchasing', 'ship_method', 'ship_base', 'numeric', 'Column purchasing.ship_method.ship_base should be type numeric');
SELECT col_not_null(     'purchasing', 'ship_method', 'ship_base', 'Column purchasing.ship_method.ship_base should be NOT NULL');
SELECT col_has_default(  'purchasing', 'ship_method', 'ship_base', 'Column purchasing.ship_method.ship_base should have a default');
SELECT col_default_is(   'purchasing', 'ship_method', 'ship_base', '0.00', 'Column purchasing.ship_method.ship_base default is');

SELECT has_column(       'purchasing', 'ship_method', 'ship_rate', 'Column purchasing.ship_method.ship_rate should exist');
SELECT col_type_is(      'purchasing', 'ship_method', 'ship_rate', 'numeric', 'Column purchasing.ship_method.ship_rate should be type numeric');
SELECT col_not_null(     'purchasing', 'ship_method', 'ship_rate', 'Column purchasing.ship_method.ship_rate should be NOT NULL');
SELECT col_has_default(  'purchasing', 'ship_method', 'ship_rate', 'Column purchasing.ship_method.ship_rate should have a default');
SELECT col_default_is(   'purchasing', 'ship_method', 'ship_rate', '0.00', 'Column purchasing.ship_method.ship_rate default is');

SELECT has_column(       'purchasing', 'ship_method', 'rowguid', 'Column purchasing.ship_method.rowguid should exist');
SELECT col_type_is(      'purchasing', 'ship_method', 'rowguid', 'uuid', 'Column purchasing.ship_method.rowguid should be type uuid');
SELECT col_not_null(     'purchasing', 'ship_method', 'rowguid', 'Column purchasing.ship_method.rowguid should be NOT NULL');
SELECT col_has_default(  'purchasing', 'ship_method', 'rowguid', 'Column purchasing.ship_method.rowguid should have a default');
SELECT col_default_is(   'purchasing', 'ship_method', 'rowguid', 'common.uuid_generate_v1()', 'Column purchasing.ship_method.rowguid default is');

SELECT has_column(       'purchasing', 'ship_method', 'modified_date', 'Column purchasing.ship_method.modified_date should exist');
SELECT col_type_is(      'purchasing', 'ship_method', 'modified_date', 'timestamp without time zone', 'Column purchasing.ship_method.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'purchasing', 'ship_method', 'modified_date', 'Column purchasing.ship_method.modified_date should be NOT NULL');
SELECT col_has_default(  'purchasing', 'ship_method', 'modified_date', 'Column purchasing.ship_method.modified_date should have a default');
SELECT col_default_is(   'purchasing', 'ship_method', 'modified_date', 'timezone(''utc''::text, now())', 'Column purchasing.ship_method.modified_date default is');

SELECT * FROM finish();
ROLLBACK;
