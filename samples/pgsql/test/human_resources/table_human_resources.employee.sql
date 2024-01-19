SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(70);

SELECT has_table(
    'human_resources', 'employee',
    'Should have table human_resources.employee'
);

SELECT hasnt_pk(
    'human_resources', 'employee',
    'Table human_resources.employee should have a primary key'
);

SELECT columns_are('human_resources'::name, 'employee'::name, ARRAY[
    'business_entity_id'::name,
    'national_id_number'::name,
    'login_id'::name,
    'organization_node'::name,
    'job_title'::name,
    'birth_date'::name,
    'marital_status'::name,
    'gender'::name,
    'hire_date'::name,
    'salaried_flag'::name,
    'holiday_hours'::name,
    'sick_leave_hours'::name,
    'current_flag'::name,
    'rowguid'::name,
    'modified_date'::name
]);

SELECT has_column(       'human_resources', 'employee', 'business_entity_id', 'Column human_resources.employee.business_entity_id should exist');
SELECT col_type_is(      'human_resources', 'employee', 'business_entity_id', 'integer', 'Column human_resources.employee.business_entity_id should be type integer');
SELECT col_not_null(     'human_resources', 'employee', 'business_entity_id', 'Column human_resources.employee.business_entity_id should be NOT NULL');
SELECT col_hasnt_default('human_resources', 'employee', 'business_entity_id', 'Column human_resources.employee.business_entity_id should not have a default');

SELECT has_column(       'human_resources', 'employee', 'national_id_number', 'Column human_resources.employee.national_id_number should exist');
SELECT col_type_is(      'human_resources', 'employee', 'national_id_number', 'character varying(15)', 'Column human_resources.employee.national_id_number should be type character varying(15)');
SELECT col_not_null(     'human_resources', 'employee', 'national_id_number', 'Column human_resources.employee.national_id_number should be NOT NULL');
SELECT col_hasnt_default('human_resources', 'employee', 'national_id_number', 'Column human_resources.employee.national_id_number should not have a default');

SELECT has_column(       'human_resources', 'employee', 'login_id', 'Column human_resources.employee.login_id should exist');
SELECT col_type_is(      'human_resources', 'employee', 'login_id', 'character varying(256)', 'Column human_resources.employee.login_id should be type character varying(256)');
SELECT col_not_null(     'human_resources', 'employee', 'login_id', 'Column human_resources.employee.login_id should be NOT NULL');
SELECT col_hasnt_default('human_resources', 'employee', 'login_id', 'Column human_resources.employee.login_id should not have a default');

SELECT has_column(       'human_resources', 'employee', 'organization_node', 'Column human_resources.employee.organization_node should exist');
SELECT col_type_is(      'human_resources', 'employee', 'organization_node', 'character varying', 'Column human_resources.employee.organization_node should be type character varying');
SELECT col_is_null(      'human_resources', 'employee', 'organization_node', 'Column human_resources.employee.organization_node should allow NULL');
SELECT col_has_default(  'human_resources', 'employee', 'organization_node', 'Column human_resources.employee.organization_node should have a default');
SELECT col_default_is(   'human_resources', 'employee', 'organization_node', '/'::character varying, 'Column human_resources.employee.organization_node default is');

SELECT has_column(       'human_resources', 'employee', 'job_title', 'Column human_resources.employee.job_title should exist');
SELECT col_type_is(      'human_resources', 'employee', 'job_title', 'character varying(50)', 'Column human_resources.employee.job_title should be type character varying(50)');
SELECT col_not_null(     'human_resources', 'employee', 'job_title', 'Column human_resources.employee.job_title should be NOT NULL');
SELECT col_hasnt_default('human_resources', 'employee', 'job_title', 'Column human_resources.employee.job_title should not have a default');

SELECT has_column(       'human_resources', 'employee', 'birth_date', 'Column human_resources.employee.birth_date should exist');
SELECT col_type_is(      'human_resources', 'employee', 'birth_date', 'date', 'Column human_resources.employee.birth_date should be type date');
SELECT col_not_null(     'human_resources', 'employee', 'birth_date', 'Column human_resources.employee.birth_date should be NOT NULL');
SELECT col_hasnt_default('human_resources', 'employee', 'birth_date', 'Column human_resources.employee.birth_date should not have a default');

SELECT has_column(       'human_resources', 'employee', 'marital_status', 'Column human_resources.employee.marital_status should exist');
SELECT col_type_is(      'human_resources', 'employee', 'marital_status', 'character(1)', 'Column human_resources.employee.marital_status should be type character(1)');
SELECT col_not_null(     'human_resources', 'employee', 'marital_status', 'Column human_resources.employee.marital_status should be NOT NULL');
SELECT col_hasnt_default('human_resources', 'employee', 'marital_status', 'Column human_resources.employee.marital_status should not have a default');

SELECT has_column(       'human_resources', 'employee', 'gender', 'Column human_resources.employee.gender should exist');
SELECT col_type_is(      'human_resources', 'employee', 'gender', 'character(1)', 'Column human_resources.employee.gender should be type character(1)');
SELECT col_not_null(     'human_resources', 'employee', 'gender', 'Column human_resources.employee.gender should be NOT NULL');
SELECT col_hasnt_default('human_resources', 'employee', 'gender', 'Column human_resources.employee.gender should not have a default');

SELECT has_column(       'human_resources', 'employee', 'hire_date', 'Column human_resources.employee.hire_date should exist');
SELECT col_type_is(      'human_resources', 'employee', 'hire_date', 'date', 'Column human_resources.employee.hire_date should be type date');
SELECT col_not_null(     'human_resources', 'employee', 'hire_date', 'Column human_resources.employee.hire_date should be NOT NULL');
SELECT col_hasnt_default('human_resources', 'employee', 'hire_date', 'Column human_resources.employee.hire_date should not have a default');

SELECT has_column(       'human_resources', 'employee', 'salaried_flag', 'Column human_resources.employee.salaried_flag should exist');
SELECT col_type_is(      'human_resources', 'employee', 'salaried_flag', 'common.flag', 'Column human_resources.employee.salaried_flag should be type common.flag');
SELECT col_not_null(     'human_resources', 'employee', 'salaried_flag', 'Column human_resources.employee.salaried_flag should be NOT NULL');
SELECT col_has_default(  'human_resources', 'employee', 'salaried_flag', 'Column human_resources.employee.salaried_flag should have a default');
SELECT col_default_is(   'human_resources', 'employee', 'salaried_flag', 'true', 'Column human_resources.employee.salaried_flag default is');

SELECT has_column(       'human_resources', 'employee', 'holiday_hours', 'Column human_resources.employee.holiday_hours should exist');
SELECT col_type_is(      'human_resources', 'employee', 'holiday_hours', 'smallint', 'Column human_resources.employee.holiday_hours should be type smallint');
SELECT col_not_null(     'human_resources', 'employee', 'holiday_hours', 'Column human_resources.employee.holiday_hours should be NOT NULL');
SELECT col_has_default(  'human_resources', 'employee', 'holiday_hours', 'Column human_resources.employee.holiday_hours should have a default');
SELECT col_default_is(   'human_resources', 'employee', 'holiday_hours', '0', 'Column human_resources.employee.holiday_hours default is');

SELECT has_column(       'human_resources', 'employee', 'sick_leave_hours', 'Column human_resources.employee.sick_leave_hours should exist');
SELECT col_type_is(      'human_resources', 'employee', 'sick_leave_hours', 'smallint', 'Column human_resources.employee.sick_leave_hours should be type smallint');
SELECT col_not_null(     'human_resources', 'employee', 'sick_leave_hours', 'Column human_resources.employee.sick_leave_hours should be NOT NULL');
SELECT col_has_default(  'human_resources', 'employee', 'sick_leave_hours', 'Column human_resources.employee.sick_leave_hours should have a default');
SELECT col_default_is(   'human_resources', 'employee', 'sick_leave_hours', '0', 'Column human_resources.employee.sick_leave_hours default is');

SELECT has_column(       'human_resources', 'employee', 'current_flag', 'Column human_resources.employee.current_flag should exist');
SELECT col_type_is(      'human_resources', 'employee', 'current_flag', 'common.flag', 'Column human_resources.employee.current_flag should be type common.flag');
SELECT col_not_null(     'human_resources', 'employee', 'current_flag', 'Column human_resources.employee.current_flag should be NOT NULL');
SELECT col_has_default(  'human_resources', 'employee', 'current_flag', 'Column human_resources.employee.current_flag should have a default');
SELECT col_default_is(   'human_resources', 'employee', 'current_flag', 'true', 'Column human_resources.employee.current_flag default is');

SELECT has_column(       'human_resources', 'employee', 'rowguid', 'Column human_resources.employee.rowguid should exist');
SELECT col_type_is(      'human_resources', 'employee', 'rowguid', 'uuid', 'Column human_resources.employee.rowguid should be type uuid');
SELECT col_not_null(     'human_resources', 'employee', 'rowguid', 'Column human_resources.employee.rowguid should be NOT NULL');
SELECT col_has_default(  'human_resources', 'employee', 'rowguid', 'Column human_resources.employee.rowguid should have a default');
SELECT col_default_is(   'human_resources', 'employee', 'rowguid', 'common.uuid_generate_v1()', 'Column human_resources.employee.rowguid default is');

SELECT has_column(       'human_resources', 'employee', 'modified_date', 'Column human_resources.employee.modified_date should exist');
SELECT col_type_is(      'human_resources', 'employee', 'modified_date', 'timestamp without time zone', 'Column human_resources.employee.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'human_resources', 'employee', 'modified_date', 'Column human_resources.employee.modified_date should be NOT NULL');
SELECT col_has_default(  'human_resources', 'employee', 'modified_date', 'Column human_resources.employee.modified_date should have a default');
SELECT col_default_is(   'human_resources', 'employee', 'modified_date', 'timezone(''utc''::text, now())', 'Column human_resources.employee.modified_date default is');

SELECT * FROM finish();
ROLLBACK;
