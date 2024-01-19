SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(22);

SELECT has_table(
    'person', 'address_type',
    'Should have table person.address_type'
);

SELECT hasnt_pk(
    'person', 'address_type',
    'Table person.address_type should have a primary key'
);

SELECT columns_are('person'::name, 'address_type'::name, ARRAY[
    'address_type_id'::name,
    'name'::name,
    'rowguid'::name,
    'modified_date'::name
]);

SELECT has_column(       'person', 'address_type', 'address_type_id', 'Column person.address_type.address_type_id should exist');
SELECT col_type_is(      'person', 'address_type', 'address_type_id', 'integer', 'Column person.address_type.address_type_id should be type integer');
SELECT col_not_null(     'person', 'address_type', 'address_type_id', 'Column person.address_type.address_type_id should be NOT NULL');
SELECT col_has_default(  'person', 'address_type', 'address_type_id', 'Column person.address_type.address_type_id should have a default');
SELECT col_default_is(   'person', 'address_type', 'address_type_id', 'nextval(''person.address_type_address_type_id_seq''::regclass)', 'Column person.address_type.address_type_id default is');

SELECT has_column(       'person', 'address_type', 'name', 'Column person.address_type.name should exist');
SELECT col_type_is(      'person', 'address_type', 'name', 'common.name', 'Column person.address_type.name should be type common.name');
SELECT col_not_null(     'person', 'address_type', 'name', 'Column person.address_type.name should be NOT NULL');
SELECT col_hasnt_default('person', 'address_type', 'name', 'Column person.address_type.name should not have a default');

SELECT has_column(       'person', 'address_type', 'rowguid', 'Column person.address_type.rowguid should exist');
SELECT col_type_is(      'person', 'address_type', 'rowguid', 'uuid', 'Column person.address_type.rowguid should be type uuid');
SELECT col_not_null(     'person', 'address_type', 'rowguid', 'Column person.address_type.rowguid should be NOT NULL');
SELECT col_has_default(  'person', 'address_type', 'rowguid', 'Column person.address_type.rowguid should have a default');
SELECT col_default_is(   'person', 'address_type', 'rowguid', 'common.uuid_generate_v1()', 'Column person.address_type.rowguid default is');

SELECT has_column(       'person', 'address_type', 'modified_date', 'Column person.address_type.modified_date should exist');
SELECT col_type_is(      'person', 'address_type', 'modified_date', 'timestamp without time zone', 'Column person.address_type.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'person', 'address_type', 'modified_date', 'Column person.address_type.modified_date should be NOT NULL');
SELECT col_has_default(  'person', 'address_type', 'modified_date', 'Column person.address_type.modified_date should have a default');
SELECT col_default_is(   'person', 'address_type', 'modified_date', 'timezone(''utc''::text, now())', 'Column person.address_type.modified_date default is');

SELECT * FROM finish();
ROLLBACK;
