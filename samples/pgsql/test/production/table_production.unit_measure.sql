SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(17);

SELECT has_table(
    'production', 'unit_measure',
    'Should have table production.unit_measure'
);

SELECT has_pk(
    'production', 'unit_measure',
    'Table production.unit_measure should have a primary key'
);

SELECT col_is_pk('production'::name, 'unit_measure'::name, ARRAY[
    'unit_measure_code'::name
],
'Primary key definition is not as expected');

SELECT columns_are('production'::name, 'unit_measure'::name, ARRAY[
    'unit_measure_code'::name,
    'name'::name,
    'modified_date'::name
]);

SELECT has_column(       'production', 'unit_measure', 'unit_measure_code', 'Column production.unit_measure.unit_measure_code should exist');
SELECT col_type_is(      'production', 'unit_measure', 'unit_measure_code', 'character(3)', 'Column production.unit_measure.unit_measure_code should be type character(3)');
SELECT col_not_null(     'production', 'unit_measure', 'unit_measure_code', 'Column production.unit_measure.unit_measure_code should be NOT NULL');
SELECT col_hasnt_default('production', 'unit_measure', 'unit_measure_code', 'Column production.unit_measure.unit_measure_code should not have a default');

SELECT has_column(       'production', 'unit_measure', 'name', 'Column production.unit_measure.name should exist');
SELECT col_type_is(      'production', 'unit_measure', 'name', 'common.name', 'Column production.unit_measure.name should be type common.name');
SELECT col_not_null(     'production', 'unit_measure', 'name', 'Column production.unit_measure.name should be NOT NULL');
SELECT col_hasnt_default('production', 'unit_measure', 'name', 'Column production.unit_measure.name should not have a default');

SELECT has_column(       'production', 'unit_measure', 'modified_date', 'Column production.unit_measure.modified_date should exist');
SELECT col_type_is(      'production', 'unit_measure', 'modified_date', 'timestamp without time zone', 'Column production.unit_measure.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'production', 'unit_measure', 'modified_date', 'Column production.unit_measure.modified_date should be NOT NULL');
SELECT col_has_default(  'production', 'unit_measure', 'modified_date', 'Column production.unit_measure.modified_date should have a default');
SELECT col_default_is(   'production', 'unit_measure', 'modified_date', 'timezone(''utc''::text, now())', 'Column production.unit_measure.modified_date default is');

SELECT * FROM finish();
ROLLBACK;

