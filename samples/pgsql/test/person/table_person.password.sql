SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(26);

SELECT has_table(
    'person', 'password',
    'Should have table person.password'
);

SELECT has_pk(
    'person', 'password',
    'Table person.password should have a primary key'
);

SELECT col_is_pk('person'::name, 'password'::name, ARRAY[
    'business_entity_id'::name
],
'Primary key definition is not as expected');

SELECT columns_are('person'::name, 'password'::name, ARRAY[
    'business_entity_id'::name,
    'password_hash'::name,
    'password_salt'::name,
    'rowguid'::name,
    'modified_date'::name
]);

SELECT has_column(       'person', 'password', 'business_entity_id', 'Column person.password.business_entity_id should exist');
SELECT col_type_is(      'person', 'password', 'business_entity_id', 'integer', 'Column person.password.business_entity_id should be type integer');
SELECT col_not_null(     'person', 'password', 'business_entity_id', 'Column person.password.business_entity_id should be NOT NULL');
SELECT col_hasnt_default('person', 'password', 'business_entity_id', 'Column person.password.business_entity_id should not have a default');

SELECT has_column(       'person', 'password', 'password_hash', 'Column person.password.password_hash should exist');
SELECT col_type_is(      'person', 'password', 'password_hash', 'character varying(128)', 'Column person.password.password_hash should be type character varying(128)');
SELECT col_not_null(     'person', 'password', 'password_hash', 'Column person.password.password_hash should be NOT NULL');
SELECT col_hasnt_default('person', 'password', 'password_hash', 'Column person.password.password_hash should not have a default');

SELECT has_column(       'person', 'password', 'password_salt', 'Column person.password.password_salt should exist');
SELECT col_type_is(      'person', 'password', 'password_salt', 'character varying(10)', 'Column person.password.password_salt should be type character varying(10)');
SELECT col_not_null(     'person', 'password', 'password_salt', 'Column person.password.password_salt should be NOT NULL');
SELECT col_hasnt_default('person', 'password', 'password_salt', 'Column person.password.password_salt should not have a default');

SELECT has_column(       'person', 'password', 'rowguid', 'Column person.password.rowguid should exist');
SELECT col_type_is(      'person', 'password', 'rowguid', 'uuid', 'Column person.password.rowguid should be type uuid');
SELECT col_not_null(     'person', 'password', 'rowguid', 'Column person.password.rowguid should be NOT NULL');
SELECT col_has_default(  'person', 'password', 'rowguid', 'Column person.password.rowguid should have a default');
SELECT col_default_is(   'person', 'password', 'rowguid', 'common.uuid_generate_v1()', 'Column person.password.rowguid default is');

SELECT has_column(       'person', 'password', 'modified_date', 'Column person.password.modified_date should exist');
SELECT col_type_is(      'person', 'password', 'modified_date', 'timestamp without time zone', 'Column person.password.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'person', 'password', 'modified_date', 'Column person.password.modified_date should be NOT NULL');
SELECT col_has_default(  'person', 'password', 'modified_date', 'Column person.password.modified_date should have a default');
SELECT col_default_is(   'person', 'password', 'modified_date', 'timezone(''utc''::text, now())', 'Column person.password.modified_date default is');

SELECT * FROM finish();
ROLLBACK;

