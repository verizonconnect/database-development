SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(34);

SELECT has_table(
    'sales', 'customer',
    'Should have table sales.customer'
);

SELECT hasnt_pk(
    'sales', 'customer',
    'Table sales.customer should have a primary key'
);

SELECT columns_are('sales'::name, 'customer'::name, ARRAY[
    'customer_id'::name,
    'person_id'::name,
    'store_id'::name,
    'territory_id'::name,
    'account_number'::name,
    'rowguid'::name,
    'modified_date'::name
]);

SELECT has_column(       'sales', 'customer', 'customer_id', 'Column sales.customer.customer_id should exist');
SELECT col_type_is(      'sales', 'customer', 'customer_id', 'integer', 'Column sales.customer.customer_id should be type integer');
SELECT col_not_null(     'sales', 'customer', 'customer_id', 'Column sales.customer.customer_id should be NOT NULL');
SELECT col_has_default(  'sales', 'customer', 'customer_id', 'Column sales.customer.customer_id should have a default');
SELECT col_default_is(   'sales', 'customer', 'customer_id', 'nextval(''sales.customer_customer_id_seq''::regclass)', 'Column sales.customer.customer_id default is');

SELECT has_column(       'sales', 'customer', 'person_id', 'Column sales.customer.person_id should exist');
SELECT col_type_is(      'sales', 'customer', 'person_id', 'integer', 'Column sales.customer.person_id should be type integer');
SELECT col_is_null(      'sales', 'customer', 'person_id', 'Column sales.customer.person_id should allow NULL');
SELECT col_hasnt_default('sales', 'customer', 'person_id', 'Column sales.customer.person_id should not have a default');

SELECT has_column(       'sales', 'customer', 'store_id', 'Column sales.customer.store_id should exist');
SELECT col_type_is(      'sales', 'customer', 'store_id', 'integer', 'Column sales.customer.store_id should be type integer');
SELECT col_is_null(      'sales', 'customer', 'store_id', 'Column sales.customer.store_id should allow NULL');
SELECT col_hasnt_default('sales', 'customer', 'store_id', 'Column sales.customer.store_id should not have a default');

SELECT has_column(       'sales', 'customer', 'territory_id', 'Column sales.customer.territory_id should exist');
SELECT col_type_is(      'sales', 'customer', 'territory_id', 'integer', 'Column sales.customer.territory_id should be type integer');
SELECT col_is_null(      'sales', 'customer', 'territory_id', 'Column sales.customer.territory_id should allow NULL');
SELECT col_hasnt_default('sales', 'customer', 'territory_id', 'Column sales.customer.territory_id should not have a default');

SELECT has_column(       'sales', 'customer', 'account_number', 'Column sales.customer.account_number should exist');
SELECT col_type_is(      'sales', 'customer', 'account_number', 'character varying', 'Column sales.customer.account_number should be type character varying');
SELECT col_is_null(      'sales', 'customer', 'account_number', 'Column sales.customer.account_number should allow NULL');
SELECT col_hasnt_default('sales', 'customer', 'account_number', 'Column sales.customer.account_number should not have a default');

SELECT has_column(       'sales', 'customer', 'rowguid', 'Column sales.customer.rowguid should exist');
SELECT col_type_is(      'sales', 'customer', 'rowguid', 'uuid', 'Column sales.customer.rowguid should be type uuid');
SELECT col_not_null(     'sales', 'customer', 'rowguid', 'Column sales.customer.rowguid should be NOT NULL');
SELECT col_has_default(  'sales', 'customer', 'rowguid', 'Column sales.customer.rowguid should have a default');
SELECT col_default_is(   'sales', 'customer', 'rowguid', 'common.uuid_generate_v1()', 'Column sales.customer.rowguid default is');

SELECT has_column(       'sales', 'customer', 'modified_date', 'Column sales.customer.modified_date should exist');
SELECT col_type_is(      'sales', 'customer', 'modified_date', 'timestamp without time zone', 'Column sales.customer.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'sales', 'customer', 'modified_date', 'Column sales.customer.modified_date should be NOT NULL');
SELECT col_has_default(  'sales', 'customer', 'modified_date', 'Column sales.customer.modified_date should have a default');
SELECT col_default_is(   'sales', 'customer', 'modified_date', 'timezone(''utc''::text, now())', 'Column sales.customer.modified_date default is');

SELECT * FROM finish();
ROLLBACK;
