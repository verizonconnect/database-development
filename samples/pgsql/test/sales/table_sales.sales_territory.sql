SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(56);

SELECT has_table(
    'sales', 'sales_territory',
    'Should have table sales.sales_territory'
);

SELECT has_pk(
    'sales', 'sales_territory',
    'Table sales.sales_territory should have a primary key'
);

SELECT has_check(
    'sales', 'sales_order_header',
    'Table sales.sales_order_header should have check contraint(s)'
);

SELECT col_is_pk('sales'::name, 'sales_territory'::name, ARRAY[
    'territory_id'::name
],
'Primary key definition is not as expected');

SELECT columns_are('sales'::name, 'sales_territory'::name, ARRAY[
    'territory_id'::name,
    'name'::name,
    'country_region_code'::name,
    'group'::name,
    'sales_ytd'::name,
    'sales_last_year'::name,
    'cost_ytd'::name,
    'cost_last_year'::name,
    'rowguid'::name,
    'modified_date'::name
]);

SELECT has_column(       'sales', 'sales_territory', 'territory_id', 'Column sales.sales_territory.territory_id should exist');
SELECT col_type_is(      'sales', 'sales_territory', 'territory_id', 'integer', 'Column sales.sales_territory.territory_id should be type integer');
SELECT col_not_null(     'sales', 'sales_territory', 'territory_id', 'Column sales.sales_territory.territory_id should be NOT NULL');
SELECT col_has_default(  'sales', 'sales_territory', 'territory_id', 'Column sales.sales_territory.territory_id should have a default');
SELECT col_default_is(   'sales', 'sales_territory', 'territory_id', 'nextval(''sales.sales_territory_territory_id_seq''::regclass)', 'Column sales.sales_territory.territory_id default is');

SELECT has_column(       'sales', 'sales_territory', 'name', 'Column sales.sales_territory.name should exist');
SELECT col_type_is(      'sales', 'sales_territory', 'name', 'common.name', 'Column sales.sales_territory.name should be type common.name');
SELECT col_not_null(     'sales', 'sales_territory', 'name', 'Column sales.sales_territory.name should be NOT NULL');
SELECT col_hasnt_default('sales', 'sales_territory', 'name', 'Column sales.sales_territory.name should not have a default');

SELECT has_column(       'sales', 'sales_territory', 'country_region_code', 'Column sales.sales_territory.country_region_code should exist');
SELECT col_type_is(      'sales', 'sales_territory', 'country_region_code', 'character varying(3)', 'Column sales.sales_territory.country_region_code should be type character varying(3)');
SELECT col_not_null(     'sales', 'sales_territory', 'country_region_code', 'Column sales.sales_territory.country_region_code should be NOT NULL');
SELECT col_hasnt_default('sales', 'sales_territory', 'country_region_code', 'Column sales.sales_territory.country_region_code should not have a default');

SELECT has_column(       'sales', 'sales_territory', 'group', 'Column sales.sales_territory."group" should exist');
SELECT col_type_is(      'sales', 'sales_territory', 'group', 'character varying(50)', 'Column sales.sales_territory."group" should be type character varying(50)');
SELECT col_not_null(     'sales', 'sales_territory', 'group', 'Column sales.sales_territory."group" should be NOT NULL');
SELECT col_hasnt_default('sales', 'sales_territory', 'group', 'Column sales.sales_territory."group" should not have a default');

SELECT has_column(       'sales', 'sales_territory', 'sales_ytd', 'Column sales.sales_territory.sales_ytd should exist');
SELECT col_type_is(      'sales', 'sales_territory', 'sales_ytd', 'numeric', 'Column sales.sales_territory.sales_ytd should be type numeric');
SELECT col_not_null(     'sales', 'sales_territory', 'sales_ytd', 'Column sales.sales_territory.sales_ytd should be NOT NULL');
SELECT col_has_default(  'sales', 'sales_territory', 'sales_ytd', 'Column sales.sales_territory.sales_ytd should have a default');
SELECT col_default_is(   'sales', 'sales_territory', 'sales_ytd', '0.00', 'Column sales.sales_territory.sales_ytd default is');
SELECT col_has_check(    'sales', 'sales_territory', 'sales_ytd', 'Column sales.sales_territory.sales_ytd should have a check constraint');

SELECT has_column(       'sales', 'sales_territory', 'sales_last_year', 'Column sales.sales_territory.sales_last_year should exist');
SELECT col_type_is(      'sales', 'sales_territory', 'sales_last_year', 'numeric', 'Column sales.sales_territory.sales_last_year should be type numeric');
SELECT col_not_null(     'sales', 'sales_territory', 'sales_last_year', 'Column sales.sales_territory.sales_last_year should be NOT NULL');
SELECT col_has_default(  'sales', 'sales_territory', 'sales_last_year', 'Column sales.sales_territory.sales_last_year should have a default');
SELECT col_default_is(   'sales', 'sales_territory', 'sales_last_year', '0.00', 'Column sales.sales_territory.sales_last_year default is');
SELECT col_has_check(    'sales', 'sales_territory', 'sales_last_year', 'Column sales.sales_territory.sales_last_year should have a check constraint');

SELECT has_column(       'sales', 'sales_territory', 'cost_ytd', 'Column sales.sales_territory.cost_ytd should exist');
SELECT col_type_is(      'sales', 'sales_territory', 'cost_ytd', 'numeric', 'Column sales.sales_territory.cost_ytd should be type numeric');
SELECT col_not_null(     'sales', 'sales_territory', 'cost_ytd', 'Column sales.sales_territory.cost_ytd should be NOT NULL');
SELECT col_has_default(  'sales', 'sales_territory', 'cost_ytd', 'Column sales.sales_territory.cost_ytd should have a default');
SELECT col_default_is(   'sales', 'sales_territory', 'cost_ytd', '0.00', 'Column sales.sales_territory.cost_ytd default is');
SELECT col_has_check(    'sales', 'sales_territory', 'cost_ytd', 'Column sales.sales_territory.cost_ytd should have a check constraint');

SELECT has_column(       'sales', 'sales_territory', 'cost_last_year', 'Column sales.sales_territory.cost_last_year should exist');
SELECT col_type_is(      'sales', 'sales_territory', 'cost_last_year', 'numeric', 'Column sales.sales_territory.cost_last_year should be type numeric');
SELECT col_not_null(     'sales', 'sales_territory', 'cost_last_year', 'Column sales.sales_territory.cost_last_year should be NOT NULL');
SELECT col_has_default(  'sales', 'sales_territory', 'cost_last_year', 'Column sales.sales_territory.cost_last_year should have a default');
SELECT col_default_is(   'sales', 'sales_territory', 'cost_last_year', '0.00', 'Column sales.sales_territory.cost_last_year default is');
SELECT col_has_check(    'sales', 'sales_territory', 'cost_last_year', 'Column sales.sales_territory.cost_last_year should have a check constraint');

SELECT has_column(       'sales', 'sales_territory', 'rowguid', 'Column sales.sales_territory.rowguid should exist');
SELECT col_type_is(      'sales', 'sales_territory', 'rowguid', 'uuid', 'Column sales.sales_territory.rowguid should be type uuid');
SELECT col_not_null(     'sales', 'sales_territory', 'rowguid', 'Column sales.sales_territory.rowguid should be NOT NULL');
SELECT col_has_default(  'sales', 'sales_territory', 'rowguid', 'Column sales.sales_territory.rowguid should have a default');
SELECT col_default_is(   'sales', 'sales_territory', 'rowguid', 'common.uuid_generate_v1()', 'Column sales.sales_territory.rowguid default is');

SELECT has_column(       'sales', 'sales_territory', 'modified_date', 'Column sales.sales_territory.modified_date should exist');
SELECT col_type_is(      'sales', 'sales_territory', 'modified_date', 'timestamp without time zone', 'Column sales.sales_territory.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'sales', 'sales_territory', 'modified_date', 'Column sales.sales_territory.modified_date should be NOT NULL');
SELECT col_has_default(  'sales', 'sales_territory', 'modified_date', 'Column sales.sales_territory.modified_date should have a default');
SELECT col_default_is(   'sales', 'sales_territory', 'modified_date', 'timezone(''utc''::text, now())', 'Column sales.sales_territory.modified_date default is');

SELECT * FROM finish();
ROLLBACK;

