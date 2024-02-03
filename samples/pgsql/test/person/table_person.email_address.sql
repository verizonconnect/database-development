SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(27);

SELECT has_table(
    'person', 'email_address',
    'Should have table person.email_address'
);

SELECT has_pk(
    'person', 'email_address',
    'Table person.email_address should have a primary key'
);

SELECT col_is_pk('person'::name, 'email_address'::name, ARRAY[
    'business_entity_id'::name,
    'email_address_id'::name
],
'Primary key definition is not as expected');

SELECT columns_are('person'::name, 'email_address'::name, ARRAY[
    'business_entity_id'::name,
    'email_address_id'::name,
    'email_address'::name,
    'rowguid'::name,
    'modified_date'::name
]);

SELECT has_column(       'person', 'email_address', 'business_entity_id', 'Column person.email_address.business_entity_id should exist');
SELECT col_type_is(      'person', 'email_address', 'business_entity_id', 'integer', 'Column person.email_address.business_entity_id should be type integer');
SELECT col_not_null(     'person', 'email_address', 'business_entity_id', 'Column person.email_address.business_entity_id should be NOT NULL');
SELECT col_hasnt_default('person', 'email_address', 'business_entity_id', 'Column person.email_address.business_entity_id should not have a default');

SELECT has_column(       'person', 'email_address', 'email_address_id', 'Column person.email_address.email_address_id should exist');
SELECT col_type_is(      'person', 'email_address', 'email_address_id', 'integer', 'Column person.email_address.email_address_id should be type integer');
SELECT col_not_null(     'person', 'email_address', 'email_address_id', 'Column person.email_address.email_address_id should be NOT NULL');
SELECT col_has_default(  'person', 'email_address', 'email_address_id', 'Column person.email_address.email_address_id should have a default');
SELECT col_default_is(   'person', 'email_address', 'email_address_id', 'nextval(''person.email_address_email_address_id_seq''::regclass)', 'Column person.email_address.email_address_id default is');

SELECT has_column(       'person', 'email_address', 'email_address', 'Column person.email_address.email_address should exist');
SELECT col_type_is(      'person', 'email_address', 'email_address', 'character varying(50)', 'Column person.email_address.email_address should be type character varying(50)');
SELECT col_is_null(      'person', 'email_address', 'email_address', 'Column person.email_address.email_address should allow NULL');
SELECT col_hasnt_default('person', 'email_address', 'email_address', 'Column person.email_address.email_address should not have a default');

SELECT has_column(       'person', 'email_address', 'rowguid', 'Column person.email_address.rowguid should exist');
SELECT col_type_is(      'person', 'email_address', 'rowguid', 'uuid', 'Column person.email_address.rowguid should be type uuid');
SELECT col_not_null(     'person', 'email_address', 'rowguid', 'Column person.email_address.rowguid should be NOT NULL');
SELECT col_has_default(  'person', 'email_address', 'rowguid', 'Column person.email_address.rowguid should have a default');
SELECT col_default_is(   'person', 'email_address', 'rowguid', 'common.uuid_generate_v1()', 'Column person.email_address.rowguid default is');

SELECT has_column(       'person', 'email_address', 'modified_date', 'Column person.email_address.modified_date should exist');
SELECT col_type_is(      'person', 'email_address', 'modified_date', 'timestamp without time zone', 'Column person.email_address.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'person', 'email_address', 'modified_date', 'Column person.email_address.modified_date should be NOT NULL');
SELECT col_has_default(  'person', 'email_address', 'modified_date', 'Column person.email_address.modified_date should have a default');
SELECT col_default_is(   'person', 'email_address', 'modified_date', 'timezone(''utc''::text, now())', 'Column person.email_address.modified_date default is');

SELECT * FROM finish();
ROLLBACK;

