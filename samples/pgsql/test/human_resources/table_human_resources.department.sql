SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(21);

SELECT has_table(
    'human_resources', 'department',
    'Should have table human_resources.department'
);

SELECT hasnt_pk(
    'human_resources', 'department',
    'Table human_resources.department should have a primary key'
);

SELECT columns_are('human_resources'::name, 'department'::name, ARRAY[
    'department_id'::name,
    'name'::name,
    'group_name'::name,
    'modified_date'::name
]);

SELECT has_column(       'human_resources', 'department', 'department_id', 'Column human_resources.department.department_id should exist');
SELECT col_type_is(      'human_resources', 'department', 'department_id', 'integer', 'Column human_resources.department.department_id should be type integer');
SELECT col_not_null(     'human_resources', 'department', 'department_id', 'Column human_resources.department.department_id should be NOT NULL');
SELECT col_has_default(  'human_resources', 'department', 'department_id', 'Column human_resources.department.department_id should have a default');
SELECT col_default_is(   'human_resources', 'department', 'department_id', 'nextval(''human_resources.department_department_id_seq''::regclass)', 'Column human_resources.department.department_id default is');

SELECT has_column(       'human_resources', 'department', 'name', 'Column human_resources.department.name should exist');
SELECT col_type_is(      'human_resources', 'department', 'name', 'common.name', 'Column human_resources.department.name should be type common.name');
SELECT col_not_null(     'human_resources', 'department', 'name', 'Column human_resources.department.name should be NOT NULL');
SELECT col_hasnt_default('human_resources', 'department', 'name', 'Column human_resources.department.name should not have a default');

SELECT has_column(       'human_resources', 'department', 'group_name', 'Column human_resources.department.group_name should exist');
SELECT col_type_is(      'human_resources', 'department', 'group_name', 'common.name', 'Column human_resources.department.group_name should be type common.name');
SELECT col_not_null(     'human_resources', 'department', 'group_name', 'Column human_resources.department.group_name should be NOT NULL');
SELECT col_hasnt_default('human_resources', 'department', 'group_name', 'Column human_resources.department.group_name should not have a default');

SELECT has_column(       'human_resources', 'department', 'modified_date', 'Column human_resources.department.modified_date should exist');
SELECT col_type_is(      'human_resources', 'department', 'modified_date', 'timestamp without time zone', 'Column human_resources.department.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'human_resources', 'department', 'modified_date', 'Column human_resources.department.modified_date should be NOT NULL');
SELECT col_has_default(  'human_resources', 'department', 'modified_date', 'Column human_resources.department.modified_date should have a default');
SELECT col_default_is(   'human_resources', 'department', 'modified_date', 'timezone(''utc''::text, now())', 'Column human_resources.department.modified_date default is');

SELECT * FROM finish();
ROLLBACK;
