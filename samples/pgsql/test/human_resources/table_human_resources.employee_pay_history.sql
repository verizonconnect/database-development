SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(24);

SELECT has_table(
    'human_resources', 'employee_pay_history',
    'Should have table human_resources.employee_pay_history'
);

SELECT hasnt_pk(
    'human_resources', 'employee_pay_history',
    'Table human_resources.employee_pay_history should have a primary key'
);

SELECT columns_are('human_resources'::name, 'employee_pay_history'::name, ARRAY[
    'business_entity_id'::name,
    'rate_change_date'::name,
    'rate'::name,
    'pay_frequency'::name,
    'modified_date'::name
]);

SELECT has_column(       'human_resources', 'employee_pay_history', 'business_entity_id', 'Column human_resources.employee_pay_history.business_entity_id should exist');
SELECT col_type_is(      'human_resources', 'employee_pay_history', 'business_entity_id', 'integer', 'Column human_resources.employee_pay_history.business_entity_id should be type integer');
SELECT col_not_null(     'human_resources', 'employee_pay_history', 'business_entity_id', 'Column human_resources.employee_pay_history.business_entity_id should be NOT NULL');
SELECT col_hasnt_default('human_resources', 'employee_pay_history', 'business_entity_id', 'Column human_resources.employee_pay_history.business_entity_id should not have a default');

SELECT has_column(       'human_resources', 'employee_pay_history', 'rate_change_date', 'Column human_resources.employee_pay_history.rate_change_date should exist');
SELECT col_type_is(      'human_resources', 'employee_pay_history', 'rate_change_date', 'timestamp without time zone', 'Column human_resources.employee_pay_history.rate_change_date should be type timestamp without time zone');
SELECT col_not_null(     'human_resources', 'employee_pay_history', 'rate_change_date', 'Column human_resources.employee_pay_history.rate_change_date should be NOT NULL');
SELECT col_hasnt_default('human_resources', 'employee_pay_history', 'rate_change_date', 'Column human_resources.employee_pay_history.rate_change_date should not have a default');

SELECT has_column(       'human_resources', 'employee_pay_history', 'rate', 'Column human_resources.employee_pay_history.rate should exist');
SELECT col_type_is(      'human_resources', 'employee_pay_history', 'rate', 'numeric', 'Column human_resources.employee_pay_history.rate should be type numeric');
SELECT col_not_null(     'human_resources', 'employee_pay_history', 'rate', 'Column human_resources.employee_pay_history.rate should be NOT NULL');
SELECT col_hasnt_default('human_resources', 'employee_pay_history', 'rate', 'Column human_resources.employee_pay_history.rate should not have a default');

SELECT has_column(       'human_resources', 'employee_pay_history', 'pay_frequency', 'Column human_resources.employee_pay_history.pay_frequency should exist');
SELECT col_type_is(      'human_resources', 'employee_pay_history', 'pay_frequency', 'smallint', 'Column human_resources.employee_pay_history.pay_frequency should be type smallint');
SELECT col_not_null(     'human_resources', 'employee_pay_history', 'pay_frequency', 'Column human_resources.employee_pay_history.pay_frequency should be NOT NULL');
SELECT col_hasnt_default('human_resources', 'employee_pay_history', 'pay_frequency', 'Column human_resources.employee_pay_history.pay_frequency should not have a default');

SELECT has_column(       'human_resources', 'employee_pay_history', 'modified_date', 'Column human_resources.employee_pay_history.modified_date should exist');
SELECT col_type_is(      'human_resources', 'employee_pay_history', 'modified_date', 'timestamp without time zone', 'Column human_resources.employee_pay_history.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'human_resources', 'employee_pay_history', 'modified_date', 'Column human_resources.employee_pay_history.modified_date should be NOT NULL');
SELECT col_has_default(  'human_resources', 'employee_pay_history', 'modified_date', 'Column human_resources.employee_pay_history.modified_date should have a default');
SELECT col_default_is(   'human_resources', 'employee_pay_history', 'modified_date', 'timezone(''utc''::text, now())', 'Column human_resources.employee_pay_history.modified_date default is');

SELECT * FROM finish();
ROLLBACK;
