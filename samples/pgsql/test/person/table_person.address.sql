SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(42);

SELECT has_table(
    'person', 'address',
    'Should have table person.address'
);

SELECT hasnt_pk(
    'person', 'address',
    'Table person.address should have a primary key'
);

SELECT columns_are('person'::name, 'address'::name, ARRAY[
    'address_id'::name,
    'address_line_1'::name,
    'address_line_2'::name,
    'city'::name,
    'state_province_id'::name,
    'postal_code'::name,
    'spatial_location'::name,
    'rowguid'::name,
    'modified_date'::name
]);

SELECT has_column(       'person', 'address', 'address_id', 'Column person.address.address_id should exist');
SELECT col_type_is(      'person', 'address', 'address_id', 'integer', 'Column person.address.address_id should be type integer');
SELECT col_not_null(     'person', 'address', 'address_id', 'Column person.address.address_id should be NOT NULL');
SELECT col_has_default(  'person', 'address', 'address_id', 'Column person.address.address_id should have a default');
SELECT col_default_is(   'person', 'address', 'address_id', 'nextval(''person.address_address_id_seq''::regclass)', 'Column person.address.address_id default is');

SELECT has_column(       'person', 'address', 'address_line_1', 'Column person.address.address_line_1 should exist');
SELECT col_type_is(      'person', 'address', 'address_line_1', 'character varying(60)', 'Column person.address.address_line_1 should be type character varying(60)');
SELECT col_not_null(     'person', 'address', 'address_line_1', 'Column person.address.address_line_1 should be NOT NULL');
SELECT col_hasnt_default('person', 'address', 'address_line_1', 'Column person.address.address_line_1 should not have a default');

SELECT has_column(       'person', 'address', 'address_line_2', 'Column person.address.address_line_2 should exist');
SELECT col_type_is(      'person', 'address', 'address_line_2', 'character varying(60)', 'Column person.address.address_line_2 should be type character varying(60)');
SELECT col_is_null(      'person', 'address', 'address_line_2', 'Column person.address.address_line_2 should allow NULL');
SELECT col_hasnt_default('person', 'address', 'address_line_2', 'Column person.address.address_line_2 should not have a default');

SELECT has_column(       'person', 'address', 'city', 'Column person.address.city should exist');
SELECT col_type_is(      'person', 'address', 'city', 'character varying(30)', 'Column person.address.city should be type character varying(30)');
SELECT col_not_null(     'person', 'address', 'city', 'Column person.address.city should be NOT NULL');
SELECT col_hasnt_default('person', 'address', 'city', 'Column person.address.city should not have a default');

SELECT has_column(       'person', 'address', 'state_province_id', 'Column person.address.state_province_id should exist');
SELECT col_type_is(      'person', 'address', 'state_province_id', 'integer', 'Column person.address.state_province_id should be type integer');
SELECT col_not_null(     'person', 'address', 'state_province_id', 'Column person.address.state_province_id should be NOT NULL');
SELECT col_hasnt_default('person', 'address', 'state_province_id', 'Column person.address.state_province_id should not have a default');

SELECT has_column(       'person', 'address', 'postal_code', 'Column person.address.postal_code should exist');
SELECT col_type_is(      'person', 'address', 'postal_code', 'character varying(15)', 'Column person.address.postal_code should be type character varying(15)');
SELECT col_not_null(     'person', 'address', 'postal_code', 'Column person.address.postal_code should be NOT NULL');
SELECT col_hasnt_default('person', 'address', 'postal_code', 'Column person.address.postal_code should not have a default');

SELECT has_column(       'person', 'address', 'spatial_location', 'Column person.address.spatial_location should exist');
SELECT col_type_is(      'person', 'address', 'spatial_location', 'bytea', 'Column person.address.spatial_location should be type bytea');
SELECT col_is_null(      'person', 'address', 'spatial_location', 'Column person.address.spatial_location should allow NULL');
SELECT col_hasnt_default('person', 'address', 'spatial_location', 'Column person.address.spatial_location should not have a default');

SELECT has_column(       'person', 'address', 'rowguid', 'Column person.address.rowguid should exist');
SELECT col_type_is(      'person', 'address', 'rowguid', 'uuid', 'Column person.address.rowguid should be type uuid');
SELECT col_not_null(     'person', 'address', 'rowguid', 'Column person.address.rowguid should be NOT NULL');
SELECT col_has_default(  'person', 'address', 'rowguid', 'Column person.address.rowguid should have a default');
SELECT col_default_is(   'person', 'address', 'rowguid', 'common.uuid_generate_v1()', 'Column person.address.rowguid default is');

SELECT has_column(       'person', 'address', 'modified_date', 'Column person.address.modified_date should exist');
SELECT col_type_is(      'person', 'address', 'modified_date', 'timestamp without time zone', 'Column person.address.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'person', 'address', 'modified_date', 'Column person.address.modified_date should be NOT NULL');
SELECT col_has_default(  'person', 'address', 'modified_date', 'Column person.address.modified_date should have a default');
SELECT col_default_is(   'person', 'address', 'modified_date', 'timezone(''utc''::text, now())', 'Column person.address.modified_date default is');

SELECT * FROM finish();
ROLLBACK;
