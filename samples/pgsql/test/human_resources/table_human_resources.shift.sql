SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(26);

SELECT has_table(
    'human_resources', 'shift',
    'Should have table human_resources.shift'
);

SELECT has_pk(
    'human_resources', 'shift',
    'Table human_resources.shift should have a primary key'
);


SELECT col_is_pk('human_resources'::name, 'shift'::name, ARRAY[
    'shift_id'::name
],
'Primary key definition is not as expected');
SELECT columns_are('human_resources'::name, 'shift'::name, ARRAY[
    'shift_id'::name,
    'name'::name,
    'start_time'::name,
    'end_time'::name,
    'modified_date'::name
]);

SELECT has_column(       'human_resources', 'shift', 'shift_id', 'Column human_resources.shift.shift_id should exist');
SELECT col_type_is(      'human_resources', 'shift', 'shift_id', 'integer', 'Column human_resources.shift.shift_id should be type integer');
SELECT col_not_null(     'human_resources', 'shift', 'shift_id', 'Column human_resources.shift.shift_id should be NOT NULL');
SELECT col_has_default(  'human_resources', 'shift', 'shift_id', 'Column human_resources.shift.shift_id should have a default');
SELECT col_default_is(   'human_resources', 'shift', 'shift_id', 'nextval(''human_resources.shift_shift_id_seq''::regclass)', 'Column human_resources.shift.shift_id default is');

SELECT has_column(       'human_resources', 'shift', 'name', 'Column human_resources.shift.name should exist');
SELECT col_type_is(      'human_resources', 'shift', 'name', 'common.name', 'Column human_resources.shift.name should be type common.name');
SELECT col_not_null(     'human_resources', 'shift', 'name', 'Column human_resources.shift.name should be NOT NULL');
SELECT col_hasnt_default('human_resources', 'shift', 'name', 'Column human_resources.shift.name should not have a default');

SELECT has_column(       'human_resources', 'shift', 'start_time', 'Column human_resources.shift.start_time should exist');
SELECT col_type_is(      'human_resources', 'shift', 'start_time', 'time without time zone', 'Column human_resources.shift.start_time should be type time without time zone');
SELECT col_not_null(     'human_resources', 'shift', 'start_time', 'Column human_resources.shift.start_time should be NOT NULL');
SELECT col_hasnt_default('human_resources', 'shift', 'start_time', 'Column human_resources.shift.start_time should not have a default');

SELECT has_column(       'human_resources', 'shift', 'end_time', 'Column human_resources.shift.end_time should exist');
SELECT col_type_is(      'human_resources', 'shift', 'end_time', 'time without time zone', 'Column human_resources.shift.end_time should be type time without time zone');
SELECT col_not_null(     'human_resources', 'shift', 'end_time', 'Column human_resources.shift.end_time should be NOT NULL');
SELECT col_hasnt_default('human_resources', 'shift', 'end_time', 'Column human_resources.shift.end_time should not have a default');

SELECT has_column(       'human_resources', 'shift', 'modified_date', 'Column human_resources.shift.modified_date should exist');
SELECT col_type_is(      'human_resources', 'shift', 'modified_date', 'timestamp without time zone', 'Column human_resources.shift.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'human_resources', 'shift', 'modified_date', 'Column human_resources.shift.modified_date should be NOT NULL');
SELECT col_has_default(  'human_resources', 'shift', 'modified_date', 'Column human_resources.shift.modified_date should have a default');
SELECT col_default_is(   'human_resources', 'shift', 'modified_date', 'timezone(''utc''::text, now())', 'Column human_resources.shift.modified_date default is');

SELECT * FROM finish();
ROLLBACK;

