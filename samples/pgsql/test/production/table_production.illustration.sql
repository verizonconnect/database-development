SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(18);

SELECT has_table(
    'production', 'illustration',
    'Should have table production.illustration'
);

SELECT has_pk(
    'production', 'illustration',
    'Table production.illustration should have a primary key'
);

SELECT col_is_pk('production'::name, 'illustration'::name, ARRAY[
    'illustration_id'::name
],
'Primary key definition is not as expected');

SELECT columns_are('production'::name, 'illustration'::name, ARRAY[
    'illustration_id'::name,
    'diagram'::name,
    'modified_date'::name
]);

SELECT has_column(       'production', 'illustration', 'illustration_id', 'Column production.illustration.illustration_id should exist');
SELECT col_type_is(      'production', 'illustration', 'illustration_id', 'integer', 'Column production.illustration.illustration_id should be type integer');
SELECT col_not_null(     'production', 'illustration', 'illustration_id', 'Column production.illustration.illustration_id should be NOT NULL');
SELECT col_has_default(  'production', 'illustration', 'illustration_id', 'Column production.illustration.illustration_id should have a default');
SELECT col_default_is(   'production', 'illustration', 'illustration_id', 'nextval(''production.illustration_illustration_id_seq''::regclass)', 'Column production.illustration.illustration_id default is');

SELECT has_column(       'production', 'illustration', 'diagram', 'Column production.illustration.diagram should exist');
SELECT col_type_is(      'production', 'illustration', 'diagram', 'xml', 'Column production.illustration.diagram should be type xml');
SELECT col_is_null(      'production', 'illustration', 'diagram', 'Column production.illustration.diagram should allow NULL');
SELECT col_hasnt_default('production', 'illustration', 'diagram', 'Column production.illustration.diagram should not have a default');

SELECT has_column(       'production', 'illustration', 'modified_date', 'Column production.illustration.modified_date should exist');
SELECT col_type_is(      'production', 'illustration', 'modified_date', 'timestamp without time zone', 'Column production.illustration.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'production', 'illustration', 'modified_date', 'Column production.illustration.modified_date should be NOT NULL');
SELECT col_has_default(  'production', 'illustration', 'modified_date', 'Column production.illustration.modified_date should have a default');
SELECT col_default_is(   'production', 'illustration', 'modified_date', 'timezone(''utc''::text, now())', 'Column production.illustration.modified_date default is');

SELECT * FROM finish();
ROLLBACK;

