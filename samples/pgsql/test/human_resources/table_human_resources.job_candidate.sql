SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(22);

SELECT has_table(
    'human_resources', 'job_candidate',
    'Should have table human_resources.job_candidate'
);

SELECT has_pk(
    'human_resources', 'job_candidate',
    'Table human_resources.job_candidate should have a primary key'
);

SELECT col_is_pk('human_resources'::name, 'job_candidate'::name, ARRAY[
    'job_candidate_id'::name
],
'Primary key definition is not as expected');

SELECT columns_are('human_resources'::name, 'job_candidate'::name, ARRAY[
    'job_candidate_id'::name,
    'business_entity_id'::name,
    'cv'::name,
    'modified_date'::name
]);

SELECT has_column(       'human_resources', 'job_candidate', 'job_candidate_id', 'Column human_resources.job_candidate.job_candidate_id should exist');
SELECT col_type_is(      'human_resources', 'job_candidate', 'job_candidate_id', 'integer', 'Column human_resources.job_candidate.job_candidate_id should be type integer');
SELECT col_not_null(     'human_resources', 'job_candidate', 'job_candidate_id', 'Column human_resources.job_candidate.job_candidate_id should be NOT NULL');
SELECT col_has_default(  'human_resources', 'job_candidate', 'job_candidate_id', 'Column human_resources.job_candidate.job_candidate_id should have a default');
SELECT col_default_is(   'human_resources', 'job_candidate', 'job_candidate_id', 'nextval(''human_resources.job_candidate_job_candidate_id_seq''::regclass)', 'Column human_resources.job_candidate.job_candidate_id default is');

SELECT has_column(       'human_resources', 'job_candidate', 'business_entity_id', 'Column human_resources.job_candidate.business_entity_id should exist');
SELECT col_type_is(      'human_resources', 'job_candidate', 'business_entity_id', 'integer', 'Column human_resources.job_candidate.business_entity_id should be type integer');
SELECT col_is_null(      'human_resources', 'job_candidate', 'business_entity_id', 'Column human_resources.job_candidate.business_entity_id should allow NULL');
SELECT col_hasnt_default('human_resources', 'job_candidate', 'business_entity_id', 'Column human_resources.job_candidate.business_entity_id should not have a default');

SELECT has_column(       'human_resources', 'job_candidate', 'cv', 'Column human_resources.job_candidate.cv should exist');
SELECT col_type_is(      'human_resources', 'job_candidate', 'cv', 'xml', 'Column human_resources.job_candidate.cv should be type xml');
SELECT col_is_null(      'human_resources', 'job_candidate', 'cv', 'Column human_resources.job_candidate.cv should allow NULL');
SELECT col_hasnt_default('human_resources', 'job_candidate', 'cv', 'Column human_resources.job_candidate.cv should not have a default');

SELECT has_column(       'human_resources', 'job_candidate', 'modified_date', 'Column human_resources.job_candidate.modified_date should exist');
SELECT col_type_is(      'human_resources', 'job_candidate', 'modified_date', 'timestamp without time zone', 'Column human_resources.job_candidate.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'human_resources', 'job_candidate', 'modified_date', 'Column human_resources.job_candidate.modified_date should be NOT NULL');
SELECT col_has_default(  'human_resources', 'job_candidate', 'modified_date', 'Column human_resources.job_candidate.modified_date should have a default');
SELECT col_default_is(   'human_resources', 'job_candidate', 'modified_date', 'timezone(''utc''::text, now())', 'Column human_resources.job_candidate.modified_date default is');

SELECT * FROM finish();
ROLLBACK;

