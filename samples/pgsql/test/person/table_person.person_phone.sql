SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(21);

SELECT has_table(
    'person', 'person_phone',
    'Should have table person.person_phone'
);

SELECT has_pk(
    'person', 'person_phone',
    'Table person.person_phone should have a primary key'
);

SELECT col_is_pk('person'::name, 'person_phone'::name, ARRAY[
    'business_entity_id'::name,
    'phone_number'::name,
    'phone_number_type_id'::name
],
'Primary key definition is not as expected');

SELECT columns_are('person'::name, 'person_phone'::name, ARRAY[
    'business_entity_id'::name,
    'phone_number'::name,
    'phone_number_type_id'::name,
    'modified_date'::name
]);

SELECT has_column(       'person', 'person_phone', 'business_entity_id', 'Column person.person_phone.business_entity_id should exist');
SELECT col_type_is(      'person', 'person_phone', 'business_entity_id', 'integer', 'Column person.person_phone.business_entity_id should be type integer');
SELECT col_not_null(     'person', 'person_phone', 'business_entity_id', 'Column person.person_phone.business_entity_id should be NOT NULL');
SELECT col_hasnt_default('person', 'person_phone', 'business_entity_id', 'Column person.person_phone.business_entity_id should not have a default');

SELECT has_column(       'person', 'person_phone', 'phone_number', 'Column person.person_phone.phone_number should exist');
SELECT col_type_is(      'person', 'person_phone', 'phone_number', 'common.phone', 'Column person.person_phone.phone_number should be type common.phone');
SELECT col_not_null(     'person', 'person_phone', 'phone_number', 'Column person.person_phone.phone_number should be NOT NULL');
SELECT col_hasnt_default('person', 'person_phone', 'phone_number', 'Column person.person_phone.phone_number should not have a default');

SELECT has_column(       'person', 'person_phone', 'phone_number_type_id', 'Column person.person_phone.phone_number_type_id should exist');
SELECT col_type_is(      'person', 'person_phone', 'phone_number_type_id', 'integer', 'Column person.person_phone.phone_number_type_id should be type integer');
SELECT col_not_null(     'person', 'person_phone', 'phone_number_type_id', 'Column person.person_phone.phone_number_type_id should be NOT NULL');
SELECT col_hasnt_default('person', 'person_phone', 'phone_number_type_id', 'Column person.person_phone.phone_number_type_id should not have a default');

SELECT has_column(       'person', 'person_phone', 'modified_date', 'Column person.person_phone.modified_date should exist');
SELECT col_type_is(      'person', 'person_phone', 'modified_date', 'timestamp without time zone', 'Column person.person_phone.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'person', 'person_phone', 'modified_date', 'Column person.person_phone.modified_date should be NOT NULL');
SELECT col_has_default(  'person', 'person_phone', 'modified_date', 'Column person.person_phone.modified_date should have a default');
SELECT col_default_is(   'person', 'person_phone', 'modified_date', 'timezone(''utc''::text, now())', 'Column person.person_phone.modified_date default is');

SELECT * FROM finish();
ROLLBACK;

