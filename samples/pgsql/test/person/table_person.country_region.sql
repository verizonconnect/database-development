SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(16);

SELECT has_table(
    'person', 'country_region',
    'Should have table person.country_region'
);

SELECT hasnt_pk(
    'person', 'country_region',
    'Table person.country_region should have a primary key'
);

SELECT columns_are('person'::name, 'country_region'::name, ARRAY[
    'country_region_code'::name,
    'name'::name,
    'modified_date'::name
]);

SELECT has_column(       'person', 'country_region', 'country_region_code', 'Column person.country_region.country_region_code should exist');
SELECT col_type_is(      'person', 'country_region', 'country_region_code', 'character varying(3)', 'Column person.country_region.country_region_code should be type character varying(3)');
SELECT col_not_null(     'person', 'country_region', 'country_region_code', 'Column person.country_region.country_region_code should be NOT NULL');
SELECT col_hasnt_default('person', 'country_region', 'country_region_code', 'Column person.country_region.country_region_code should not have a default');

SELECT has_column(       'person', 'country_region', 'name', 'Column person.country_region.name should exist');
SELECT col_type_is(      'person', 'country_region', 'name', 'common.name', 'Column person.country_region.name should be type common.name');
SELECT col_not_null(     'person', 'country_region', 'name', 'Column person.country_region.name should be NOT NULL');
SELECT col_hasnt_default('person', 'country_region', 'name', 'Column person.country_region.name should not have a default');

SELECT has_column(       'person', 'country_region', 'modified_date', 'Column person.country_region.modified_date should exist');
SELECT col_type_is(      'person', 'country_region', 'modified_date', 'timestamp without time zone', 'Column person.country_region.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'person', 'country_region', 'modified_date', 'Column person.country_region.modified_date should be NOT NULL');
SELECT col_has_default(  'person', 'country_region', 'modified_date', 'Column person.country_region.modified_date should have a default');
SELECT col_default_is(   'person', 'country_region', 'modified_date', 'timezone(''utc''::text, now())', 'Column person.country_region.modified_date default is');

SELECT * FROM finish();
ROLLBACK;
