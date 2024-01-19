SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(29);

SELECT has_table(
    'sales', 'sales_territory_history',
    'Should have table sales.sales_territory_history'
);

SELECT hasnt_pk(
    'sales', 'sales_territory_history',
    'Table sales.sales_territory_history should have a primary key'
);

SELECT columns_are('sales'::name, 'sales_territory_history'::name, ARRAY[
    'business_entity_id'::name,
    'territory_id'::name,
    'start_date'::name,
    'end_date'::name,
    'rowguid'::name,
    'modified_date'::name
]);

SELECT has_column(       'sales', 'sales_territory_history', 'business_entity_id', 'Column sales.sales_territory_history.business_entity_id should exist');
SELECT col_type_is(      'sales', 'sales_territory_history', 'business_entity_id', 'integer', 'Column sales.sales_territory_history.business_entity_id should be type integer');
SELECT col_not_null(     'sales', 'sales_territory_history', 'business_entity_id', 'Column sales.sales_territory_history.business_entity_id should be NOT NULL');
SELECT col_hasnt_default('sales', 'sales_territory_history', 'business_entity_id', 'Column sales.sales_territory_history.business_entity_id should not have a default');

SELECT has_column(       'sales', 'sales_territory_history', 'territory_id', 'Column sales.sales_territory_history.territory_id should exist');
SELECT col_type_is(      'sales', 'sales_territory_history', 'territory_id', 'integer', 'Column sales.sales_territory_history.territory_id should be type integer');
SELECT col_not_null(     'sales', 'sales_territory_history', 'territory_id', 'Column sales.sales_territory_history.territory_id should be NOT NULL');
SELECT col_hasnt_default('sales', 'sales_territory_history', 'territory_id', 'Column sales.sales_territory_history.territory_id should not have a default');

SELECT has_column(       'sales', 'sales_territory_history', 'start_date', 'Column sales.sales_territory_history.start_date should exist');
SELECT col_type_is(      'sales', 'sales_territory_history', 'start_date', 'timestamp without time zone', 'Column sales.sales_territory_history.start_date should be type timestamp without time zone');
SELECT col_not_null(     'sales', 'sales_territory_history', 'start_date', 'Column sales.sales_territory_history.start_date should be NOT NULL');
SELECT col_hasnt_default('sales', 'sales_territory_history', 'start_date', 'Column sales.sales_territory_history.start_date should not have a default');

SELECT has_column(       'sales', 'sales_territory_history', 'end_date', 'Column sales.sales_territory_history.end_date should exist');
SELECT col_type_is(      'sales', 'sales_territory_history', 'end_date', 'timestamp without time zone', 'Column sales.sales_territory_history.end_date should be type timestamp without time zone');
SELECT col_is_null(      'sales', 'sales_territory_history', 'end_date', 'Column sales.sales_territory_history.end_date should allow NULL');
SELECT col_hasnt_default('sales', 'sales_territory_history', 'end_date', 'Column sales.sales_territory_history.end_date should not have a default');

SELECT has_column(       'sales', 'sales_territory_history', 'rowguid', 'Column sales.sales_territory_history.rowguid should exist');
SELECT col_type_is(      'sales', 'sales_territory_history', 'rowguid', 'uuid', 'Column sales.sales_territory_history.rowguid should be type uuid');
SELECT col_not_null(     'sales', 'sales_territory_history', 'rowguid', 'Column sales.sales_territory_history.rowguid should be NOT NULL');
SELECT col_has_default(  'sales', 'sales_territory_history', 'rowguid', 'Column sales.sales_territory_history.rowguid should have a default');
SELECT col_default_is(   'sales', 'sales_territory_history', 'rowguid', 'common.uuid_generate_v1()', 'Column sales.sales_territory_history.rowguid default is');

SELECT has_column(       'sales', 'sales_territory_history', 'modified_date', 'Column sales.sales_territory_history.modified_date should exist');
SELECT col_type_is(      'sales', 'sales_territory_history', 'modified_date', 'timestamp without time zone', 'Column sales.sales_territory_history.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'sales', 'sales_territory_history', 'modified_date', 'Column sales.sales_territory_history.modified_date should be NOT NULL');
SELECT col_has_default(  'sales', 'sales_territory_history', 'modified_date', 'Column sales.sales_territory_history.modified_date should have a default');
SELECT col_default_is(   'sales', 'sales_territory_history', 'modified_date', 'timezone(''utc''::text, now())', 'Column sales.sales_territory_history.modified_date default is');

SELECT * FROM finish();
ROLLBACK;
