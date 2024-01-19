SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(17);

SELECT has_table(
    'production', 'scrap_reason',
    'Should have table production.scrap_reason'
);

SELECT hasnt_pk(
    'production', 'scrap_reason',
    'Table production.scrap_reason should have a primary key'
);

SELECT columns_are('production'::name, 'scrap_reason'::name, ARRAY[
    'scrap_reason_id'::name,
    'name'::name,
    'modified_date'::name
]);

SELECT has_column(       'production', 'scrap_reason', 'scrap_reason_id', 'Column production.scrap_reason.scrap_reason_id should exist');
SELECT col_type_is(      'production', 'scrap_reason', 'scrap_reason_id', 'integer', 'Column production.scrap_reason.scrap_reason_id should be type integer');
SELECT col_not_null(     'production', 'scrap_reason', 'scrap_reason_id', 'Column production.scrap_reason.scrap_reason_id should be NOT NULL');
SELECT col_has_default(  'production', 'scrap_reason', 'scrap_reason_id', 'Column production.scrap_reason.scrap_reason_id should have a default');
SELECT col_default_is(   'production', 'scrap_reason', 'scrap_reason_id', 'nextval(''production.scrap_reason_scrap_reason_id_seq''::regclass)', 'Column production.scrap_reason.scrap_reason_id default is');

SELECT has_column(       'production', 'scrap_reason', 'name', 'Column production.scrap_reason.name should exist');
SELECT col_type_is(      'production', 'scrap_reason', 'name', 'common.name', 'Column production.scrap_reason.name should be type common.name');
SELECT col_not_null(     'production', 'scrap_reason', 'name', 'Column production.scrap_reason.name should be NOT NULL');
SELECT col_hasnt_default('production', 'scrap_reason', 'name', 'Column production.scrap_reason.name should not have a default');

SELECT has_column(       'production', 'scrap_reason', 'modified_date', 'Column production.scrap_reason.modified_date should exist');
SELECT col_type_is(      'production', 'scrap_reason', 'modified_date', 'timestamp without time zone', 'Column production.scrap_reason.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'production', 'scrap_reason', 'modified_date', 'Column production.scrap_reason.modified_date should be NOT NULL');
SELECT col_has_default(  'production', 'scrap_reason', 'modified_date', 'Column production.scrap_reason.modified_date should have a default');
SELECT col_default_is(   'production', 'scrap_reason', 'modified_date', 'timezone(''utc''::text, now())', 'Column production.scrap_reason.modified_date default is');

SELECT * FROM finish();
ROLLBACK;
