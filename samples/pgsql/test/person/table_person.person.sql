SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(63);

SELECT has_table(
    'person', 'person',
    'Should have table person.person'
);

SELECT has_pk(
    'person', 'person',
    'Table person.person should have a primary key'
);

SELECT has_check(
    'person', 'person',
    'Table person.person should have check contraint(s)'
);

SELECT col_is_pk('person'::name, 'person'::name, ARRAY[
    'business_entity_id'::name
],
'Primary key definition is not as expected');

SELECT columns_are('person'::name, 'person'::name, ARRAY[
    'business_entity_id'::name,
    'person_type'::name,
    'name_style'::name,
    'title'::name,
    'first_name'::name,
    'middle_name'::name,
    'last_name'::name,
    'suffix'::name,
    'email_promotion'::name,
    'additional_contact_info'::name,
    'demographics'::name,
    'rowguid'::name,
    'modified_date'::name
]);

SELECT has_column(       'person', 'person', 'business_entity_id', 'Column person.person.business_entity_id should exist');
SELECT col_type_is(      'person', 'person', 'business_entity_id', 'integer', 'Column person.person.business_entity_id should be type integer');
SELECT col_not_null(     'person', 'person', 'business_entity_id', 'Column person.person.business_entity_id should be NOT NULL');
SELECT col_hasnt_default('person', 'person', 'business_entity_id', 'Column person.person.business_entity_id should not have a default');

SELECT has_column(       'person', 'person', 'person_type', 'Column person.person.person_type should exist');
SELECT col_type_is(      'person', 'person', 'person_type', 'character(2)', 'Column person.person.person_type should be type character(2)');
SELECT col_not_null(     'person', 'person', 'person_type', 'Column person.person.person_type should be NOT NULL');
SELECT col_hasnt_default('person', 'person', 'person_type', 'Column person.person.person_type should not have a default');
SELECT col_has_check(    'person', 'person', 'person_type', 'Column person.person.person_type should have a check constraint');

SELECT has_column(       'person', 'person', 'name_style', 'Column person.person.name_style should exist');
SELECT col_type_is(      'person', 'person', 'name_style', 'common.name_style', 'Column person.person.name_style should be type common.name_style');
SELECT col_not_null(     'person', 'person', 'name_style', 'Column person.person.name_style should be NOT NULL');
SELECT col_has_default(  'person', 'person', 'name_style', 'Column person.person.name_style should have a default');
SELECT col_default_is(   'person', 'person', 'name_style', 'false', 'Column person.person.name_style default is');

SELECT has_column(       'person', 'person', 'title', 'Column person.person.title should exist');
SELECT col_type_is(      'person', 'person', 'title', 'character varying(8)', 'Column person.person.title should be type character varying(8)');
SELECT col_is_null(      'person', 'person', 'title', 'Column person.person.title should allow NULL');
SELECT col_hasnt_default('person', 'person', 'title', 'Column person.person.title should not have a default');

SELECT has_column(       'person', 'person', 'first_name', 'Column person.person.first_name should exist');
SELECT col_type_is(      'person', 'person', 'first_name', 'common.name', 'Column person.person.first_name should be type common.name');
SELECT col_not_null(     'person', 'person', 'first_name', 'Column person.person.first_name should be NOT NULL');
SELECT col_hasnt_default('person', 'person', 'first_name', 'Column person.person.first_name should not have a default');

SELECT has_column(       'person', 'person', 'middle_name', 'Column person.person.middle_name should exist');
SELECT col_type_is(      'person', 'person', 'middle_name', 'common.name', 'Column person.person.middle_name should be type common.name');
SELECT col_is_null(      'person', 'person', 'middle_name', 'Column person.person.middle_name should allow NULL');
SELECT col_hasnt_default('person', 'person', 'middle_name', 'Column person.person.middle_name should not have a default');

SELECT has_column(       'person', 'person', 'last_name', 'Column person.person.last_name should exist');
SELECT col_type_is(      'person', 'person', 'last_name', 'common.name', 'Column person.person.last_name should be type common.name');
SELECT col_not_null(     'person', 'person', 'last_name', 'Column person.person.last_name should be NOT NULL');
SELECT col_hasnt_default('person', 'person', 'last_name', 'Column person.person.last_name should not have a default');

SELECT has_column(       'person', 'person', 'suffix', 'Column person.person.suffix should exist');
SELECT col_type_is(      'person', 'person', 'suffix', 'character varying(10)', 'Column person.person.suffix should be type character varying(10)');
SELECT col_is_null(      'person', 'person', 'suffix', 'Column person.person.suffix should allow NULL');
SELECT col_hasnt_default('person', 'person', 'suffix', 'Column person.person.suffix should not have a default');

SELECT has_column(       'person', 'person', 'email_promotion', 'Column person.person.email_promotion should exist');
SELECT col_type_is(      'person', 'person', 'email_promotion', 'integer', 'Column person.person.email_promotion should be type integer');
SELECT col_not_null(     'person', 'person', 'email_promotion', 'Column person.person.email_promotion should be NOT NULL');
SELECT col_has_default(  'person', 'person', 'email_promotion', 'Column person.person.email_promotion should have a default');
SELECT col_default_is(   'person', 'person', 'email_promotion', '0', 'Column person.person.email_promotion default is');
SELECT col_has_check(    'person', 'person', 'email_promotion', 'Column person.person.email_promotion should have a check constraint');

SELECT has_column(       'person', 'person', 'additional_contact_info', 'Column person.person.additional_contact_info should exist');
SELECT col_type_is(      'person', 'person', 'additional_contact_info', 'xml', 'Column person.person.additional_contact_info should be type xml');
SELECT col_is_null(      'person', 'person', 'additional_contact_info', 'Column person.person.additional_contact_info should allow NULL');
SELECT col_hasnt_default('person', 'person', 'additional_contact_info', 'Column person.person.additional_contact_info should not have a default');

SELECT has_column(       'person', 'person', 'demographics', 'Column person.person.demographics should exist');
SELECT col_type_is(      'person', 'person', 'demographics', 'xml', 'Column person.person.demographics should be type xml');
SELECT col_is_null(      'person', 'person', 'demographics', 'Column person.person.demographics should allow NULL');
SELECT col_hasnt_default('person', 'person', 'demographics', 'Column person.person.demographics should not have a default');

SELECT has_column(       'person', 'person', 'rowguid', 'Column person.person.rowguid should exist');
SELECT col_type_is(      'person', 'person', 'rowguid', 'uuid', 'Column person.person.rowguid should be type uuid');
SELECT col_not_null(     'person', 'person', 'rowguid', 'Column person.person.rowguid should be NOT NULL');
SELECT col_has_default(  'person', 'person', 'rowguid', 'Column person.person.rowguid should have a default');
SELECT col_default_is(   'person', 'person', 'rowguid', 'common.uuid_generate_v1()', 'Column person.person.rowguid default is');

SELECT has_column(       'person', 'person', 'modified_date', 'Column person.person.modified_date should exist');
SELECT col_type_is(      'person', 'person', 'modified_date', 'timestamp without time zone', 'Column person.person.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'person', 'person', 'modified_date', 'Column person.person.modified_date should be NOT NULL');
SELECT col_has_default(  'person', 'person', 'modified_date', 'Column person.person.modified_date should have a default');
SELECT col_default_is(   'person', 'person', 'modified_date', 'timezone(''utc''::text, now())', 'Column person.person.modified_date default is');

SELECT * FROM finish();
ROLLBACK;

