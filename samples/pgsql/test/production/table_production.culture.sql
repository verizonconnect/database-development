SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(16);

SELECT has_table(
    'production', 'culture',
    'Should have table production.culture'
);

SELECT hasnt_pk(
    'production', 'culture',
    'Table production.culture should have a primary key'
);

SELECT columns_are('production'::name, 'culture'::name, ARRAY[
    'culture_id'::name,
    'name'::name,
    'modified_date'::name
]);

SELECT has_column(       'production', 'culture', 'culture_id', 'Column production.culture.culture_id should exist');
SELECT col_type_is(      'production', 'culture', 'culture_id', 'character(6)', 'Column production.culture.culture_id should be type character(6)');
SELECT col_not_null(     'production', 'culture', 'culture_id', 'Column production.culture.culture_id should be NOT NULL');
SELECT col_hasnt_default('production', 'culture', 'culture_id', 'Column production.culture.culture_id should not have a default');

SELECT has_column(       'production', 'culture', 'name', 'Column production.culture.name should exist');
SELECT col_type_is(      'production', 'culture', 'name', 'common.name', 'Column production.culture.name should be type common.name');
SELECT col_not_null(     'production', 'culture', 'name', 'Column production.culture.name should be NOT NULL');
SELECT col_hasnt_default('production', 'culture', 'name', 'Column production.culture.name should not have a default');

SELECT has_column(       'production', 'culture', 'modified_date', 'Column production.culture.modified_date should exist');
SELECT col_type_is(      'production', 'culture', 'modified_date', 'timestamp without time zone', 'Column production.culture.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'production', 'culture', 'modified_date', 'Column production.culture.modified_date should be NOT NULL');
SELECT col_has_default(  'production', 'culture', 'modified_date', 'Column production.culture.modified_date should have a default');
SELECT col_default_is(   'production', 'culture', 'modified_date', 'timezone(''utc''::text, now())', 'Column production.culture.modified_date default is');

SELECT * FROM finish();
ROLLBACK;
