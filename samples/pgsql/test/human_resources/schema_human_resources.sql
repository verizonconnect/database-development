SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(12);

SELECT functions_are('human_resources', ARRAY[
    'set_employee__hire_info'
]);

SELECT tables_are('human_resources', ARRAY[
    'department',
    'employee',
    'employee_department_history',
    'employee_pay_history',
    'job_candidate',
    'shift'
]);

SELECT table_owner_is('human_resources','department','postgres','human_resources.department owner is postgres');
SELECT table_owner_is('human_resources','employee','postgres','human_resources.employee owner is postgres');
SELECT table_owner_is('human_resources','employee_department_history','postgres','human_resources.employee_department_history owner is postgres');
SELECT table_owner_is('human_resources','employee_pay_history','postgres','human_resources.employee_pay_history owner is postgres');
SELECT table_owner_is('human_resources','job_candidate','postgres','human_resources.job_candidate owner is postgres');
SELECT table_owner_is('human_resources','shift','postgres','human_resources.shift owner is postgres');
SELECT sequences_are('human_resources', ARRAY[
    'department_department_id_seq',
    'job_candidate_job_candidate_id_seq',
    'shift_shift_id_seq'
]);

SELECT sequence_owner_is('human_resources','department_department_id_seq','postgres','human_resources.department_department_id_seq owner is postgres');
SELECT sequence_owner_is('human_resources','job_candidate_job_candidate_id_seq','postgres','human_resources.job_candidate_job_candidate_id_seq owner is postgres');
SELECT sequence_owner_is('human_resources','shift_shift_id_seq','postgres','human_resources.shift_shift_id_seq owner is postgres');

SELECT * FROM finish();
ROLLBACK;
