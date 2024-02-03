SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(31);

SELECT has_table(
    'production', 'location',
    'Should have table production.location'
);

SELECT has_pk(
    'production', 'location',
    'Table production.location should have a primary key'
);

SELECT has_pk(
    'production', 'location',
    'Table production.location should have a primary key'
);

SELECT col_is_pk('production'::name, 'location'::name, ARRAY[
    'location_id'::name
],
'Primary key definition is not as expected');

SELECT columns_are('production'::name, 'location'::name, ARRAY[
    'location_id'::name,
    'name'::name,
    'cost_rate'::name,
    'availability'::name,
    'modified_date'::name
]);

SELECT has_column(       'production', 'location', 'location_id', 'Column production.location.location_id should exist');
SELECT col_type_is(      'production', 'location', 'location_id', 'integer', 'Column production.location.location_id should be type integer');
SELECT col_not_null(     'production', 'location', 'location_id', 'Column production.location.location_id should be NOT NULL');
SELECT col_has_default(  'production', 'location', 'location_id', 'Column production.location.location_id should have a default');
SELECT col_default_is(   'production', 'location', 'location_id', 'nextval(''production.location_location_id_seq''::regclass)', 'Column production.location.location_id default is');

SELECT has_column(       'production', 'location', 'name', 'Column production.location.name should exist');
SELECT col_type_is(      'production', 'location', 'name', 'common.name', 'Column production.location.name should be type common.name');
SELECT col_not_null(     'production', 'location', 'name', 'Column production.location.name should be NOT NULL');
SELECT col_hasnt_default('production', 'location', 'name', 'Column production.location.name should not have a default');

SELECT has_column(       'production', 'location', 'cost_rate', 'Column production.location.cost_rate should exist');
SELECT col_type_is(      'production', 'location', 'cost_rate', 'numeric', 'Column production.location.cost_rate should be type numeric');
SELECT col_not_null(     'production', 'location', 'cost_rate', 'Column production.location.cost_rate should be NOT NULL');
SELECT col_has_default(  'production', 'location', 'cost_rate', 'Column production.location.cost_rate should have a default');
SELECT col_default_is(   'production', 'location', 'cost_rate', '0.00', 'Column production.location.cost_rate default is');
SELECT col_has_check(    'production', 'location', 'cost_rate', 'Column production.location.cost_rate should have a check constraint');

SELECT has_column(       'production', 'location', 'availability', 'Column production.location.availability should exist');
SELECT col_type_is(      'production', 'location', 'availability', 'numeric(8,2)', 'Column production.location.availability should be type numeric(8,2)');
SELECT col_not_null(     'production', 'location', 'availability', 'Column production.location.availability should be NOT NULL');
SELECT col_has_default(  'production', 'location', 'availability', 'Column production.location.availability should have a default');
SELECT col_default_is(   'production', 'location', 'availability', '0.00', 'Column production.location.availability default is');
SELECT col_has_check(    'production', 'location', 'availability', 'Column production.location.availability should have a check constraint');

SELECT has_column(       'production', 'location', 'modified_date', 'Column production.location.modified_date should exist');
SELECT col_type_is(      'production', 'location', 'modified_date', 'timestamp without time zone', 'Column production.location.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'production', 'location', 'modified_date', 'Column production.location.modified_date should be NOT NULL');
SELECT col_has_default(  'production', 'location', 'modified_date', 'Column production.location.modified_date should have a default');
SELECT col_default_is(   'production', 'location', 'modified_date', 'timezone(''utc''::text, now())', 'Column production.location.modified_date default is');

SELECT * FROM finish();
ROLLBACK;

