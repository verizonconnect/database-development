SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(30);

SELECT has_table(
    'sales', 'store',
    'Should have table sales.store'
);

SELECT has_pk(
    'sales', 'store',
    'Table sales.store should have a primary key'
);

SELECT col_is_pk('sales'::name, 'store'::name, ARRAY[
    'business_entity_id'::name
],
'Primary key definition is not as expected');

SELECT columns_are('sales'::name, 'store'::name, ARRAY[
    'business_entity_id'::name,
    'name'::name,
    'sales_person_id'::name,
    'demographics'::name,
    'rowguid'::name,
    'modified_date'::name
]);

SELECT has_column(       'sales', 'store', 'business_entity_id', 'Column sales.store.business_entity_id should exist');
SELECT col_type_is(      'sales', 'store', 'business_entity_id', 'integer', 'Column sales.store.business_entity_id should be type integer');
SELECT col_not_null(     'sales', 'store', 'business_entity_id', 'Column sales.store.business_entity_id should be NOT NULL');
SELECT col_hasnt_default('sales', 'store', 'business_entity_id', 'Column sales.store.business_entity_id should not have a default');

SELECT has_column(       'sales', 'store', 'name', 'Column sales.store.name should exist');
SELECT col_type_is(      'sales', 'store', 'name', 'common.name', 'Column sales.store.name should be type common.name');
SELECT col_not_null(     'sales', 'store', 'name', 'Column sales.store.name should be NOT NULL');
SELECT col_hasnt_default('sales', 'store', 'name', 'Column sales.store.name should not have a default');

SELECT has_column(       'sales', 'store', 'sales_person_id', 'Column sales.store.sales_person_id should exist');
SELECT col_type_is(      'sales', 'store', 'sales_person_id', 'integer', 'Column sales.store.sales_person_id should be type integer');
SELECT col_is_null(      'sales', 'store', 'sales_person_id', 'Column sales.store.sales_person_id should allow NULL');
SELECT col_hasnt_default('sales', 'store', 'sales_person_id', 'Column sales.store.sales_person_id should not have a default');

SELECT has_column(       'sales', 'store', 'demographics', 'Column sales.store.demographics should exist');
SELECT col_type_is(      'sales', 'store', 'demographics', 'xml', 'Column sales.store.demographics should be type xml');
SELECT col_is_null(      'sales', 'store', 'demographics', 'Column sales.store.demographics should allow NULL');
SELECT col_hasnt_default('sales', 'store', 'demographics', 'Column sales.store.demographics should not have a default');

SELECT has_column(       'sales', 'store', 'rowguid', 'Column sales.store.rowguid should exist');
SELECT col_type_is(      'sales', 'store', 'rowguid', 'uuid', 'Column sales.store.rowguid should be type uuid');
SELECT col_not_null(     'sales', 'store', 'rowguid', 'Column sales.store.rowguid should be NOT NULL');
SELECT col_has_default(  'sales', 'store', 'rowguid', 'Column sales.store.rowguid should have a default');
SELECT col_default_is(   'sales', 'store', 'rowguid', 'common.uuid_generate_v1()', 'Column sales.store.rowguid default is');

SELECT has_column(       'sales', 'store', 'modified_date', 'Column sales.store.modified_date should exist');
SELECT col_type_is(      'sales', 'store', 'modified_date', 'timestamp without time zone', 'Column sales.store.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'sales', 'store', 'modified_date', 'Column sales.store.modified_date should be NOT NULL');
SELECT col_has_default(  'sales', 'store', 'modified_date', 'Column sales.store.modified_date should have a default');
SELECT col_default_is(   'sales', 'store', 'modified_date', 'timezone(''utc''::text, now())', 'Column sales.store.modified_date default is');

SELECT * FROM finish();
ROLLBACK;

