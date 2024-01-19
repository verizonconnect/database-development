SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(45);

SELECT has_table(
    'sales', 'sales_person',
    'Should have table sales.sales_person'
);

SELECT hasnt_pk(
    'sales', 'sales_person',
    'Table sales.sales_person should have a primary key'
);

SELECT columns_are('sales'::name, 'sales_person'::name, ARRAY[
    'business_entity_id'::name,
    'territory_id'::name,
    'sales_quota'::name,
    'bonus'::name,
    'commission_pct'::name,
    'sales_ytd'::name,
    'sales_last_year'::name,
    'rowguid'::name,
    'modified_date'::name
]);

SELECT has_column(       'sales', 'sales_person', 'business_entity_id', 'Column sales.sales_person.business_entity_id should exist');
SELECT col_type_is(      'sales', 'sales_person', 'business_entity_id', 'integer', 'Column sales.sales_person.business_entity_id should be type integer');
SELECT col_not_null(     'sales', 'sales_person', 'business_entity_id', 'Column sales.sales_person.business_entity_id should be NOT NULL');
SELECT col_hasnt_default('sales', 'sales_person', 'business_entity_id', 'Column sales.sales_person.business_entity_id should not have a default');

SELECT has_column(       'sales', 'sales_person', 'territory_id', 'Column sales.sales_person.territory_id should exist');
SELECT col_type_is(      'sales', 'sales_person', 'territory_id', 'integer', 'Column sales.sales_person.territory_id should be type integer');
SELECT col_is_null(      'sales', 'sales_person', 'territory_id', 'Column sales.sales_person.territory_id should allow NULL');
SELECT col_hasnt_default('sales', 'sales_person', 'territory_id', 'Column sales.sales_person.territory_id should not have a default');

SELECT has_column(       'sales', 'sales_person', 'sales_quota', 'Column sales.sales_person.sales_quota should exist');
SELECT col_type_is(      'sales', 'sales_person', 'sales_quota', 'numeric', 'Column sales.sales_person.sales_quota should be type numeric');
SELECT col_is_null(      'sales', 'sales_person', 'sales_quota', 'Column sales.sales_person.sales_quota should allow NULL');
SELECT col_hasnt_default('sales', 'sales_person', 'sales_quota', 'Column sales.sales_person.sales_quota should not have a default');

SELECT has_column(       'sales', 'sales_person', 'bonus', 'Column sales.sales_person.bonus should exist');
SELECT col_type_is(      'sales', 'sales_person', 'bonus', 'numeric', 'Column sales.sales_person.bonus should be type numeric');
SELECT col_not_null(     'sales', 'sales_person', 'bonus', 'Column sales.sales_person.bonus should be NOT NULL');
SELECT col_has_default(  'sales', 'sales_person', 'bonus', 'Column sales.sales_person.bonus should have a default');
SELECT col_default_is(   'sales', 'sales_person', 'bonus', '0.00', 'Column sales.sales_person.bonus default is');

SELECT has_column(       'sales', 'sales_person', 'commission_pct', 'Column sales.sales_person.commission_pct should exist');
SELECT col_type_is(      'sales', 'sales_person', 'commission_pct', 'numeric', 'Column sales.sales_person.commission_pct should be type numeric');
SELECT col_not_null(     'sales', 'sales_person', 'commission_pct', 'Column sales.sales_person.commission_pct should be NOT NULL');
SELECT col_has_default(  'sales', 'sales_person', 'commission_pct', 'Column sales.sales_person.commission_pct should have a default');
SELECT col_default_is(   'sales', 'sales_person', 'commission_pct', '0.00', 'Column sales.sales_person.commission_pct default is');

SELECT has_column(       'sales', 'sales_person', 'sales_ytd', 'Column sales.sales_person.sales_ytd should exist');
SELECT col_type_is(      'sales', 'sales_person', 'sales_ytd', 'numeric', 'Column sales.sales_person.sales_ytd should be type numeric');
SELECT col_not_null(     'sales', 'sales_person', 'sales_ytd', 'Column sales.sales_person.sales_ytd should be NOT NULL');
SELECT col_has_default(  'sales', 'sales_person', 'sales_ytd', 'Column sales.sales_person.sales_ytd should have a default');
SELECT col_default_is(   'sales', 'sales_person', 'sales_ytd', '0.00', 'Column sales.sales_person.sales_ytd default is');

SELECT has_column(       'sales', 'sales_person', 'sales_last_year', 'Column sales.sales_person.sales_last_year should exist');
SELECT col_type_is(      'sales', 'sales_person', 'sales_last_year', 'numeric', 'Column sales.sales_person.sales_last_year should be type numeric');
SELECT col_not_null(     'sales', 'sales_person', 'sales_last_year', 'Column sales.sales_person.sales_last_year should be NOT NULL');
SELECT col_has_default(  'sales', 'sales_person', 'sales_last_year', 'Column sales.sales_person.sales_last_year should have a default');
SELECT col_default_is(   'sales', 'sales_person', 'sales_last_year', '0.00', 'Column sales.sales_person.sales_last_year default is');

SELECT has_column(       'sales', 'sales_person', 'rowguid', 'Column sales.sales_person.rowguid should exist');
SELECT col_type_is(      'sales', 'sales_person', 'rowguid', 'uuid', 'Column sales.sales_person.rowguid should be type uuid');
SELECT col_not_null(     'sales', 'sales_person', 'rowguid', 'Column sales.sales_person.rowguid should be NOT NULL');
SELECT col_has_default(  'sales', 'sales_person', 'rowguid', 'Column sales.sales_person.rowguid should have a default');
SELECT col_default_is(   'sales', 'sales_person', 'rowguid', 'common.uuid_generate_v1()', 'Column sales.sales_person.rowguid default is');

SELECT has_column(       'sales', 'sales_person', 'modified_date', 'Column sales.sales_person.modified_date should exist');
SELECT col_type_is(      'sales', 'sales_person', 'modified_date', 'timestamp without time zone', 'Column sales.sales_person.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'sales', 'sales_person', 'modified_date', 'Column sales.sales_person.modified_date should be NOT NULL');
SELECT col_has_default(  'sales', 'sales_person', 'modified_date', 'Column sales.sales_person.modified_date should have a default');
SELECT col_default_is(   'sales', 'sales_person', 'modified_date', 'timezone(''utc''::text, now())', 'Column sales.sales_person.modified_date default is');

SELECT * FROM finish();
ROLLBACK;
