SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(39);

SELECT has_table(
    'person', 'state_province',
    'Should have table person.state_province'
);

SELECT hasnt_pk(
    'person', 'state_province',
    'Table person.state_province should have a primary key'
);

SELECT columns_are('person'::name, 'state_province'::name, ARRAY[
    'state_province_id'::name,
    'state_province_code'::name,
    'country_region_code'::name,
    'is_only_state_province_flag'::name,
    'name'::name,
    'territory_id'::name,
    'rowguid'::name,
    'modified_date'::name
]);

SELECT has_column(       'person', 'state_province', 'state_province_id', 'Column person.state_province.state_province_id should exist');
SELECT col_type_is(      'person', 'state_province', 'state_province_id', 'integer', 'Column person.state_province.state_province_id should be type integer');
SELECT col_not_null(     'person', 'state_province', 'state_province_id', 'Column person.state_province.state_province_id should be NOT NULL');
SELECT col_has_default(  'person', 'state_province', 'state_province_id', 'Column person.state_province.state_province_id should have a default');
SELECT col_default_is(   'person', 'state_province', 'state_province_id', 'nextval(''person.state_province_state_province_id_seq''::regclass)', 'Column person.state_province.state_province_id default is');

SELECT has_column(       'person', 'state_province', 'state_province_code', 'Column person.state_province.state_province_code should exist');
SELECT col_type_is(      'person', 'state_province', 'state_province_code', 'character(3)', 'Column person.state_province.state_province_code should be type character(3)');
SELECT col_not_null(     'person', 'state_province', 'state_province_code', 'Column person.state_province.state_province_code should be NOT NULL');
SELECT col_hasnt_default('person', 'state_province', 'state_province_code', 'Column person.state_province.state_province_code should not have a default');

SELECT has_column(       'person', 'state_province', 'country_region_code', 'Column person.state_province.country_region_code should exist');
SELECT col_type_is(      'person', 'state_province', 'country_region_code', 'character varying(3)', 'Column person.state_province.country_region_code should be type character varying(3)');
SELECT col_not_null(     'person', 'state_province', 'country_region_code', 'Column person.state_province.country_region_code should be NOT NULL');
SELECT col_hasnt_default('person', 'state_province', 'country_region_code', 'Column person.state_province.country_region_code should not have a default');

SELECT has_column(       'person', 'state_province', 'is_only_state_province_flag', 'Column person.state_province.is_only_state_province_flag should exist');
SELECT col_type_is(      'person', 'state_province', 'is_only_state_province_flag', 'common.flag', 'Column person.state_province.is_only_state_province_flag should be type common.flag');
SELECT col_not_null(     'person', 'state_province', 'is_only_state_province_flag', 'Column person.state_province.is_only_state_province_flag should be NOT NULL');
SELECT col_has_default(  'person', 'state_province', 'is_only_state_province_flag', 'Column person.state_province.is_only_state_province_flag should have a default');
SELECT col_default_is(   'person', 'state_province', 'is_only_state_province_flag', 'true', 'Column person.state_province.is_only_state_province_flag default is');

SELECT has_column(       'person', 'state_province', 'name', 'Column person.state_province.name should exist');
SELECT col_type_is(      'person', 'state_province', 'name', 'common.name', 'Column person.state_province.name should be type common.name');
SELECT col_not_null(     'person', 'state_province', 'name', 'Column person.state_province.name should be NOT NULL');
SELECT col_hasnt_default('person', 'state_province', 'name', 'Column person.state_province.name should not have a default');

SELECT has_column(       'person', 'state_province', 'territory_id', 'Column person.state_province.territory_id should exist');
SELECT col_type_is(      'person', 'state_province', 'territory_id', 'integer', 'Column person.state_province.territory_id should be type integer');
SELECT col_not_null(     'person', 'state_province', 'territory_id', 'Column person.state_province.territory_id should be NOT NULL');
SELECT col_hasnt_default('person', 'state_province', 'territory_id', 'Column person.state_province.territory_id should not have a default');

SELECT has_column(       'person', 'state_province', 'rowguid', 'Column person.state_province.rowguid should exist');
SELECT col_type_is(      'person', 'state_province', 'rowguid', 'uuid', 'Column person.state_province.rowguid should be type uuid');
SELECT col_not_null(     'person', 'state_province', 'rowguid', 'Column person.state_province.rowguid should be NOT NULL');
SELECT col_has_default(  'person', 'state_province', 'rowguid', 'Column person.state_province.rowguid should have a default');
SELECT col_default_is(   'person', 'state_province', 'rowguid', 'common.uuid_generate_v1()', 'Column person.state_province.rowguid default is');

SELECT has_column(       'person', 'state_province', 'modified_date', 'Column person.state_province.modified_date should exist');
SELECT col_type_is(      'person', 'state_province', 'modified_date', 'timestamp without time zone', 'Column person.state_province.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'person', 'state_province', 'modified_date', 'Column person.state_province.modified_date should be NOT NULL');
SELECT col_has_default(  'person', 'state_province', 'modified_date', 'Column person.state_province.modified_date should have a default');
SELECT col_default_is(   'person', 'state_province', 'modified_date', 'timezone(''utc''::text, now())', 'Column person.state_province.modified_date default is');

SELECT * FROM finish();
ROLLBACK;
