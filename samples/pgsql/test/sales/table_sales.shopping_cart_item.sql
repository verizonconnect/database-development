SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(34);

SELECT has_table(
    'sales', 'shopping_cart_item',
    'Should have table sales.shopping_cart_item'
);

SELECT has_pk(
    'sales', 'shopping_cart_item',
    'Table sales.shopping_cart_item should have a primary key'
);

SELECT has_check(
    'sales', 'shopping_cart_item',
    'Table sales.shopping_cart_item should have check contraint(s)'
);

SELECT col_is_pk('sales'::name, 'shopping_cart_item'::name, ARRAY[
    'shopping_cart_item_id'::name
],
'Primary key definition is not as expected');

SELECT columns_are('sales'::name, 'shopping_cart_item'::name, ARRAY[
    'shopping_cart_item_id'::name,
    'shopping_cart_id'::name,
    'quantity'::name,
    'product_id'::name,
    'date_created'::name,
    'modified_date'::name
]);

SELECT has_column(       'sales', 'shopping_cart_item', 'shopping_cart_item_id', 'Column sales.shopping_cart_item.shopping_cart_item_id should exist');
SELECT col_type_is(      'sales', 'shopping_cart_item', 'shopping_cart_item_id', 'integer', 'Column sales.shopping_cart_item.shopping_cart_item_id should be type integer');
SELECT col_not_null(     'sales', 'shopping_cart_item', 'shopping_cart_item_id', 'Column sales.shopping_cart_item.shopping_cart_item_id should be NOT NULL');
SELECT col_has_default(  'sales', 'shopping_cart_item', 'shopping_cart_item_id', 'Column sales.shopping_cart_item.shopping_cart_item_id should have a default');
SELECT col_default_is(   'sales', 'shopping_cart_item', 'shopping_cart_item_id', 'nextval(''sales.shopping_cart_item_shopping_cart_item_id_seq''::regclass)', 'Column sales.shopping_cart_item.shopping_cart_item_id default is');

SELECT has_column(       'sales', 'shopping_cart_item', 'shopping_cart_id', 'Column sales.shopping_cart_item.shopping_cart_id should exist');
SELECT col_type_is(      'sales', 'shopping_cart_item', 'shopping_cart_id', 'character varying(50)', 'Column sales.shopping_cart_item.shopping_cart_id should be type character varying(50)');
SELECT col_not_null(     'sales', 'shopping_cart_item', 'shopping_cart_id', 'Column sales.shopping_cart_item.shopping_cart_id should be NOT NULL');
SELECT col_hasnt_default('sales', 'shopping_cart_item', 'shopping_cart_id', 'Column sales.shopping_cart_item.shopping_cart_id should not have a default');

SELECT has_column(       'sales', 'shopping_cart_item', 'quantity', 'Column sales.shopping_cart_item.quantity should exist');
SELECT col_type_is(      'sales', 'shopping_cart_item', 'quantity', 'integer', 'Column sales.shopping_cart_item.quantity should be type integer');
SELECT col_not_null(     'sales', 'shopping_cart_item', 'quantity', 'Column sales.shopping_cart_item.quantity should be NOT NULL');
SELECT col_has_default(  'sales', 'shopping_cart_item', 'quantity', 'Column sales.shopping_cart_item.quantity should have a default');
SELECT col_default_is(   'sales', 'shopping_cart_item', 'quantity', '1', 'Column sales.shopping_cart_item.quantity default is');
SELECT col_has_check(    'sales', 'shopping_cart_item', 'quantity', 'Column sales.shopping_cart_item.quantity should have a check constraint');

SELECT has_column(       'sales', 'shopping_cart_item', 'product_id', 'Column sales.shopping_cart_item.product_id should exist');
SELECT col_type_is(      'sales', 'shopping_cart_item', 'product_id', 'integer', 'Column sales.shopping_cart_item.product_id should be type integer');
SELECT col_not_null(     'sales', 'shopping_cart_item', 'product_id', 'Column sales.shopping_cart_item.product_id should be NOT NULL');
SELECT col_hasnt_default('sales', 'shopping_cart_item', 'product_id', 'Column sales.shopping_cart_item.product_id should not have a default');

SELECT has_column(       'sales', 'shopping_cart_item', 'date_created', 'Column sales.shopping_cart_item.date_created should exist');
SELECT col_type_is(      'sales', 'shopping_cart_item', 'date_created', 'timestamp without time zone', 'Column sales.shopping_cart_item.date_created should be type timestamp without time zone');
SELECT col_not_null(     'sales', 'shopping_cart_item', 'date_created', 'Column sales.shopping_cart_item.date_created should be NOT NULL');
SELECT col_has_default(  'sales', 'shopping_cart_item', 'date_created', 'Column sales.shopping_cart_item.date_created should have a default');
SELECT col_default_is(   'sales', 'shopping_cart_item', 'date_created', 'timezone(''utc''::text, now())', 'Column sales.shopping_cart_item.date_created default is');

SELECT has_column(       'sales', 'shopping_cart_item', 'modified_date', 'Column sales.shopping_cart_item.modified_date should exist');
SELECT col_type_is(      'sales', 'shopping_cart_item', 'modified_date', 'timestamp without time zone', 'Column sales.shopping_cart_item.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'sales', 'shopping_cart_item', 'modified_date', 'Column sales.shopping_cart_item.modified_date should be NOT NULL');
SELECT col_has_default(  'sales', 'shopping_cart_item', 'modified_date', 'Column sales.shopping_cart_item.modified_date should have a default');
SELECT col_default_is(   'sales', 'shopping_cart_item', 'modified_date', 'timezone(''utc''::text, now())', 'Column sales.shopping_cart_item.modified_date default is');

SELECT * FROM finish();
ROLLBACK;

