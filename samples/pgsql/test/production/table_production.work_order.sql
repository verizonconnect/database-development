SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(41);

SELECT has_table(
    'production', 'work_order',
    'Should have table production.work_order'
);

SELECT hasnt_pk(
    'production', 'work_order',
    'Table production.work_order should have a primary key'
);

SELECT columns_are('production'::name, 'work_order'::name, ARRAY[
    'work_order_id'::name,
    'product_id'::name,
    'order_qty'::name,
    'scrapped_qty'::name,
    'start_date'::name,
    'end_date'::name,
    'due_date'::name,
    'scrap_reason_id'::name,
    'modified_date'::name
]);

SELECT has_column(       'production', 'work_order', 'work_order_id', 'Column production.work_order.work_order_id should exist');
SELECT col_type_is(      'production', 'work_order', 'work_order_id', 'integer', 'Column production.work_order.work_order_id should be type integer');
SELECT col_not_null(     'production', 'work_order', 'work_order_id', 'Column production.work_order.work_order_id should be NOT NULL');
SELECT col_has_default(  'production', 'work_order', 'work_order_id', 'Column production.work_order.work_order_id should have a default');
SELECT col_default_is(   'production', 'work_order', 'work_order_id', 'nextval(''production.work_order_work_order_id_seq''::regclass)', 'Column production.work_order.work_order_id default is');

SELECT has_column(       'production', 'work_order', 'product_id', 'Column production.work_order.product_id should exist');
SELECT col_type_is(      'production', 'work_order', 'product_id', 'integer', 'Column production.work_order.product_id should be type integer');
SELECT col_not_null(     'production', 'work_order', 'product_id', 'Column production.work_order.product_id should be NOT NULL');
SELECT col_hasnt_default('production', 'work_order', 'product_id', 'Column production.work_order.product_id should not have a default');

SELECT has_column(       'production', 'work_order', 'order_qty', 'Column production.work_order.order_qty should exist');
SELECT col_type_is(      'production', 'work_order', 'order_qty', 'integer', 'Column production.work_order.order_qty should be type integer');
SELECT col_not_null(     'production', 'work_order', 'order_qty', 'Column production.work_order.order_qty should be NOT NULL');
SELECT col_hasnt_default('production', 'work_order', 'order_qty', 'Column production.work_order.order_qty should not have a default');

SELECT has_column(       'production', 'work_order', 'scrapped_qty', 'Column production.work_order.scrapped_qty should exist');
SELECT col_type_is(      'production', 'work_order', 'scrapped_qty', 'smallint', 'Column production.work_order.scrapped_qty should be type smallint');
SELECT col_not_null(     'production', 'work_order', 'scrapped_qty', 'Column production.work_order.scrapped_qty should be NOT NULL');
SELECT col_hasnt_default('production', 'work_order', 'scrapped_qty', 'Column production.work_order.scrapped_qty should not have a default');

SELECT has_column(       'production', 'work_order', 'start_date', 'Column production.work_order.start_date should exist');
SELECT col_type_is(      'production', 'work_order', 'start_date', 'timestamp without time zone', 'Column production.work_order.start_date should be type timestamp without time zone');
SELECT col_not_null(     'production', 'work_order', 'start_date', 'Column production.work_order.start_date should be NOT NULL');
SELECT col_hasnt_default('production', 'work_order', 'start_date', 'Column production.work_order.start_date should not have a default');

SELECT has_column(       'production', 'work_order', 'end_date', 'Column production.work_order.end_date should exist');
SELECT col_type_is(      'production', 'work_order', 'end_date', 'timestamp without time zone', 'Column production.work_order.end_date should be type timestamp without time zone');
SELECT col_is_null(      'production', 'work_order', 'end_date', 'Column production.work_order.end_date should allow NULL');
SELECT col_hasnt_default('production', 'work_order', 'end_date', 'Column production.work_order.end_date should not have a default');

SELECT has_column(       'production', 'work_order', 'due_date', 'Column production.work_order.due_date should exist');
SELECT col_type_is(      'production', 'work_order', 'due_date', 'timestamp without time zone', 'Column production.work_order.due_date should be type timestamp without time zone');
SELECT col_not_null(     'production', 'work_order', 'due_date', 'Column production.work_order.due_date should be NOT NULL');
SELECT col_hasnt_default('production', 'work_order', 'due_date', 'Column production.work_order.due_date should not have a default');

SELECT has_column(       'production', 'work_order', 'scrap_reason_id', 'Column production.work_order.scrap_reason_id should exist');
SELECT col_type_is(      'production', 'work_order', 'scrap_reason_id', 'smallint', 'Column production.work_order.scrap_reason_id should be type smallint');
SELECT col_is_null(      'production', 'work_order', 'scrap_reason_id', 'Column production.work_order.scrap_reason_id should allow NULL');
SELECT col_hasnt_default('production', 'work_order', 'scrap_reason_id', 'Column production.work_order.scrap_reason_id should not have a default');

SELECT has_column(       'production', 'work_order', 'modified_date', 'Column production.work_order.modified_date should exist');
SELECT col_type_is(      'production', 'work_order', 'modified_date', 'timestamp without time zone', 'Column production.work_order.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'production', 'work_order', 'modified_date', 'Column production.work_order.modified_date should be NOT NULL');
SELECT col_has_default(  'production', 'work_order', 'modified_date', 'Column production.work_order.modified_date should have a default');
SELECT col_default_is(   'production', 'work_order', 'modified_date', 'timezone(''utc''::text, now())', 'Column production.work_order.modified_date default is');

SELECT * FROM finish();
ROLLBACK;
