SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(25);

SELECT has_table(
    'person', 'business_entity_address',
    'Should have table person.business_entity_address'
);

SELECT hasnt_pk(
    'person', 'business_entity_address',
    'Table person.business_entity_address should have a primary key'
);

SELECT columns_are('person'::name, 'business_entity_address'::name, ARRAY[
    'business_entity_id'::name,
    'address_id'::name,
    'address_type_id'::name,
    'rowguid'::name,
    'modified_date'::name
]);

SELECT has_column(       'person', 'business_entity_address', 'business_entity_id', 'Column person.business_entity_address.business_entity_id should exist');
SELECT col_type_is(      'person', 'business_entity_address', 'business_entity_id', 'integer', 'Column person.business_entity_address.business_entity_id should be type integer');
SELECT col_not_null(     'person', 'business_entity_address', 'business_entity_id', 'Column person.business_entity_address.business_entity_id should be NOT NULL');
SELECT col_hasnt_default('person', 'business_entity_address', 'business_entity_id', 'Column person.business_entity_address.business_entity_id should not have a default');

SELECT has_column(       'person', 'business_entity_address', 'address_id', 'Column person.business_entity_address.address_id should exist');
SELECT col_type_is(      'person', 'business_entity_address', 'address_id', 'integer', 'Column person.business_entity_address.address_id should be type integer');
SELECT col_not_null(     'person', 'business_entity_address', 'address_id', 'Column person.business_entity_address.address_id should be NOT NULL');
SELECT col_hasnt_default('person', 'business_entity_address', 'address_id', 'Column person.business_entity_address.address_id should not have a default');

SELECT has_column(       'person', 'business_entity_address', 'address_type_id', 'Column person.business_entity_address.address_type_id should exist');
SELECT col_type_is(      'person', 'business_entity_address', 'address_type_id', 'integer', 'Column person.business_entity_address.address_type_id should be type integer');
SELECT col_not_null(     'person', 'business_entity_address', 'address_type_id', 'Column person.business_entity_address.address_type_id should be NOT NULL');
SELECT col_hasnt_default('person', 'business_entity_address', 'address_type_id', 'Column person.business_entity_address.address_type_id should not have a default');

SELECT has_column(       'person', 'business_entity_address', 'rowguid', 'Column person.business_entity_address.rowguid should exist');
SELECT col_type_is(      'person', 'business_entity_address', 'rowguid', 'uuid', 'Column person.business_entity_address.rowguid should be type uuid');
SELECT col_not_null(     'person', 'business_entity_address', 'rowguid', 'Column person.business_entity_address.rowguid should be NOT NULL');
SELECT col_has_default(  'person', 'business_entity_address', 'rowguid', 'Column person.business_entity_address.rowguid should have a default');
SELECT col_default_is(   'person', 'business_entity_address', 'rowguid', 'common.uuid_generate_v1()', 'Column person.business_entity_address.rowguid default is');

SELECT has_column(       'person', 'business_entity_address', 'modified_date', 'Column person.business_entity_address.modified_date should exist');
SELECT col_type_is(      'person', 'business_entity_address', 'modified_date', 'timestamp without time zone', 'Column person.business_entity_address.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'person', 'business_entity_address', 'modified_date', 'Column person.business_entity_address.modified_date should be NOT NULL');
SELECT col_has_default(  'person', 'business_entity_address', 'modified_date', 'Column person.business_entity_address.modified_date should have a default');
SELECT col_default_is(   'person', 'business_entity_address', 'modified_date', 'timezone(''utc''::text, now())', 'Column person.business_entity_address.modified_date default is');

SELECT * FROM finish();
ROLLBACK;
