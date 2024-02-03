SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(19);

SELECT has_table(
    'person', 'business_entity',
    'Should have table person.business_entity'
);

SELECT has_pk(
    'person', 'business_entity',
    'Table person.business_entity should have a primary key'
);

SELECT col_is_pk('person'::name, 'business_entity'::name, ARRAY[
    'business_entity_id'::name
],
'Primary key definition is not as expected');

SELECT columns_are('person'::name, 'business_entity'::name, ARRAY[
    'business_entity_id'::name,
    'rowguid'::name,
    'modified_date'::name
]);

SELECT has_column(       'person', 'business_entity', 'business_entity_id', 'Column person.business_entity.business_entity_id should exist');
SELECT col_type_is(      'person', 'business_entity', 'business_entity_id', 'integer', 'Column person.business_entity.business_entity_id should be type integer');
SELECT col_not_null(     'person', 'business_entity', 'business_entity_id', 'Column person.business_entity.business_entity_id should be NOT NULL');
SELECT col_has_default(  'person', 'business_entity', 'business_entity_id', 'Column person.business_entity.business_entity_id should have a default');
SELECT col_default_is(   'person', 'business_entity', 'business_entity_id', 'nextval(''person.business_entity_business_entity_id_seq''::regclass)', 'Column person.business_entity.business_entity_id default is');

SELECT has_column(       'person', 'business_entity', 'rowguid', 'Column person.business_entity.rowguid should exist');
SELECT col_type_is(      'person', 'business_entity', 'rowguid', 'uuid', 'Column person.business_entity.rowguid should be type uuid');
SELECT col_not_null(     'person', 'business_entity', 'rowguid', 'Column person.business_entity.rowguid should be NOT NULL');
SELECT col_has_default(  'person', 'business_entity', 'rowguid', 'Column person.business_entity.rowguid should have a default');
SELECT col_default_is(   'person', 'business_entity', 'rowguid', 'common.uuid_generate_v1()', 'Column person.business_entity.rowguid default is');

SELECT has_column(       'person', 'business_entity', 'modified_date', 'Column person.business_entity.modified_date should exist');
SELECT col_type_is(      'person', 'business_entity', 'modified_date', 'timestamp without time zone', 'Column person.business_entity.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'person', 'business_entity', 'modified_date', 'Column person.business_entity.modified_date should be NOT NULL');
SELECT col_has_default(  'person', 'business_entity', 'modified_date', 'Column person.business_entity.modified_date should have a default');
SELECT col_default_is(   'person', 'business_entity', 'modified_date', 'timezone(''utc''::text, now())', 'Column person.business_entity.modified_date default is');

SELECT * FROM finish();
ROLLBACK;

