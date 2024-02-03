SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(31);

SELECT has_table(
    'human_resources', 'employee_department_history',
    'Should have table human_resources.employee_department_history'
);

SELECT has_pk(
    'human_resources', 'employee_department_history',
    'Table human_resources.employee_department_history should have a primary key'
);

SELECT has_check(
    'human_resources', 'employee_department_history',
    'Table human_resources.employee_department_history should have check contraint(s)'
);

SELECT col_is_pk('human_resources'::name, 'employee_department_history'::name, ARRAY[
    'business_entity_id'::name,
    'start_date'::name,
    'department_id'::name,
    'shift_id'::name
],
'Primary key definition is not as expected');

SELECT columns_are('human_resources'::name, 'employee_department_history'::name, ARRAY[
    'business_entity_id'::name,
    'department_id'::name,
    'shift_id'::name,
    'start_date'::name,
    'end_date'::name,
    'modified_date'::name
]);

SELECT has_column(       'human_resources', 'employee_department_history', 'business_entity_id', 'Column human_resources.employee_department_history.business_entity_id should exist');
SELECT col_type_is(      'human_resources', 'employee_department_history', 'business_entity_id', 'integer', 'Column human_resources.employee_department_history.business_entity_id should be type integer');
SELECT col_not_null(     'human_resources', 'employee_department_history', 'business_entity_id', 'Column human_resources.employee_department_history.business_entity_id should be NOT NULL');
SELECT col_hasnt_default('human_resources', 'employee_department_history', 'business_entity_id', 'Column human_resources.employee_department_history.business_entity_id should not have a default');

SELECT has_column(       'human_resources', 'employee_department_history', 'department_id', 'Column human_resources.employee_department_history.department_id should exist');
SELECT col_type_is(      'human_resources', 'employee_department_history', 'department_id', 'smallint', 'Column human_resources.employee_department_history.department_id should be type smallint');
SELECT col_not_null(     'human_resources', 'employee_department_history', 'department_id', 'Column human_resources.employee_department_history.department_id should be NOT NULL');
SELECT col_hasnt_default('human_resources', 'employee_department_history', 'department_id', 'Column human_resources.employee_department_history.department_id should not have a default');

SELECT has_column(       'human_resources', 'employee_department_history', 'shift_id', 'Column human_resources.employee_department_history.shift_id should exist');
SELECT col_type_is(      'human_resources', 'employee_department_history', 'shift_id', 'smallint', 'Column human_resources.employee_department_history.shift_id should be type smallint');
SELECT col_not_null(     'human_resources', 'employee_department_history', 'shift_id', 'Column human_resources.employee_department_history.shift_id should be NOT NULL');
SELECT col_hasnt_default('human_resources', 'employee_department_history', 'shift_id', 'Column human_resources.employee_department_history.shift_id should not have a default');

SELECT has_column(       'human_resources', 'employee_department_history', 'start_date', 'Column human_resources.employee_department_history.start_date should exist');
SELECT col_type_is(      'human_resources', 'employee_department_history', 'start_date', 'date', 'Column human_resources.employee_department_history.start_date should be type date');
SELECT col_not_null(     'human_resources', 'employee_department_history', 'start_date', 'Column human_resources.employee_department_history.start_date should be NOT NULL');
SELECT col_hasnt_default('human_resources', 'employee_department_history', 'start_date', 'Column human_resources.employee_department_history.start_date should not have a default');

SELECT has_column(       'human_resources', 'employee_department_history', 'end_date', 'Column human_resources.employee_department_history.end_date should exist');
SELECT col_type_is(      'human_resources', 'employee_department_history', 'end_date', 'date', 'Column human_resources.employee_department_history.end_date should be type date');
SELECT col_is_null(      'human_resources', 'employee_department_history', 'end_date', 'Column human_resources.employee_department_history.end_date should allow NULL');
SELECT col_hasnt_default('human_resources', 'employee_department_history', 'end_date', 'Column human_resources.employee_department_history.end_date should not have a default');
SELECT col_has_check(    'human_resources', 'employee_department_history', ARRAY['end_date'::name,'start_date'::name], 'Columns human_resources.employee_department_history.[end_date,start_date] should have a check constraint');

SELECT has_column(       'human_resources', 'employee_department_history', 'modified_date', 'Column human_resources.employee_department_history.modified_date should exist');
SELECT col_type_is(      'human_resources', 'employee_department_history', 'modified_date', 'timestamp without time zone', 'Column human_resources.employee_department_history.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'human_resources', 'employee_department_history', 'modified_date', 'Column human_resources.employee_department_history.modified_date should be NOT NULL');
SELECT col_has_default(  'human_resources', 'employee_department_history', 'modified_date', 'Column human_resources.employee_department_history.modified_date should have a default');
SELECT col_default_is(   'human_resources', 'employee_department_history', 'modified_date', 'timezone(''utc''::text, now())', 'Column human_resources.employee_department_history.modified_date default is');

SELECT * FROM finish();
ROLLBACK;

