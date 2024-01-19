SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(17);

SELECT has_table(
    'person', 'contact_type',
    'Should have table person.contact_type'
);

SELECT hasnt_pk(
    'person', 'contact_type',
    'Table person.contact_type should have a primary key'
);

SELECT columns_are('person'::name, 'contact_type'::name, ARRAY[
    'contact_type_id'::name,
    'name'::name,
    'modified_date'::name
]);

SELECT has_column(       'person', 'contact_type', 'contact_type_id', 'Column person.contact_type.contact_type_id should exist');
SELECT col_type_is(      'person', 'contact_type', 'contact_type_id', 'integer', 'Column person.contact_type.contact_type_id should be type integer');
SELECT col_not_null(     'person', 'contact_type', 'contact_type_id', 'Column person.contact_type.contact_type_id should be NOT NULL');
SELECT col_has_default(  'person', 'contact_type', 'contact_type_id', 'Column person.contact_type.contact_type_id should have a default');
SELECT col_default_is(   'person', 'contact_type', 'contact_type_id', 'nextval(''person.contact_type_contact_type_id_seq''::regclass)', 'Column person.contact_type.contact_type_id default is');

SELECT has_column(       'person', 'contact_type', 'name', 'Column person.contact_type.name should exist');
SELECT col_type_is(      'person', 'contact_type', 'name', 'common.name', 'Column person.contact_type.name should be type common.name');
SELECT col_not_null(     'person', 'contact_type', 'name', 'Column person.contact_type.name should be NOT NULL');
SELECT col_hasnt_default('person', 'contact_type', 'name', 'Column person.contact_type.name should not have a default');

SELECT has_column(       'person', 'contact_type', 'modified_date', 'Column person.contact_type.modified_date should exist');
SELECT col_type_is(      'person', 'contact_type', 'modified_date', 'timestamp without time zone', 'Column person.contact_type.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'person', 'contact_type', 'modified_date', 'Column person.contact_type.modified_date should be NOT NULL');
SELECT col_has_default(  'person', 'contact_type', 'modified_date', 'Column person.contact_type.modified_date should have a default');
SELECT col_default_is(   'person', 'contact_type', 'modified_date', 'timezone(''utc''::text, now())', 'Column person.contact_type.modified_date default is');

SELECT * FROM finish();
ROLLBACK;
