SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(52);

SELECT has_table(
    'production', 'work_order_routing',
    'Should have table production.work_order_routing'
);

SELECT hasnt_pk(
    'production', 'work_order_routing',
    'Table production.work_order_routing should have a primary key'
);

SELECT columns_are('production'::name, 'work_order_routing'::name, ARRAY[
    'work_order_id'::name,
    'product_id'::name,
    'operation_sequence'::name,
    'location_id'::name,
    'scheduled_start_date'::name,
    'scheduled_end_date'::name,
    'actual_start_date'::name,
    'actual_end_date'::name,
    'actual_resource_hrs'::name,
    'planned_cost'::name,
    'actual_cost'::name,
    'modified_date'::name
]);

SELECT has_column(       'production', 'work_order_routing', 'work_order_id', 'Column production.work_order_routing.work_order_id should exist');
SELECT col_type_is(      'production', 'work_order_routing', 'work_order_id', 'integer', 'Column production.work_order_routing.work_order_id should be type integer');
SELECT col_not_null(     'production', 'work_order_routing', 'work_order_id', 'Column production.work_order_routing.work_order_id should be NOT NULL');
SELECT col_hasnt_default('production', 'work_order_routing', 'work_order_id', 'Column production.work_order_routing.work_order_id should not have a default');

SELECT has_column(       'production', 'work_order_routing', 'product_id', 'Column production.work_order_routing.product_id should exist');
SELECT col_type_is(      'production', 'work_order_routing', 'product_id', 'integer', 'Column production.work_order_routing.product_id should be type integer');
SELECT col_not_null(     'production', 'work_order_routing', 'product_id', 'Column production.work_order_routing.product_id should be NOT NULL');
SELECT col_hasnt_default('production', 'work_order_routing', 'product_id', 'Column production.work_order_routing.product_id should not have a default');

SELECT has_column(       'production', 'work_order_routing', 'operation_sequence', 'Column production.work_order_routing.operation_sequence should exist');
SELECT col_type_is(      'production', 'work_order_routing', 'operation_sequence', 'smallint', 'Column production.work_order_routing.operation_sequence should be type smallint');
SELECT col_not_null(     'production', 'work_order_routing', 'operation_sequence', 'Column production.work_order_routing.operation_sequence should be NOT NULL');
SELECT col_hasnt_default('production', 'work_order_routing', 'operation_sequence', 'Column production.work_order_routing.operation_sequence should not have a default');

SELECT has_column(       'production', 'work_order_routing', 'location_id', 'Column production.work_order_routing.location_id should exist');
SELECT col_type_is(      'production', 'work_order_routing', 'location_id', 'smallint', 'Column production.work_order_routing.location_id should be type smallint');
SELECT col_not_null(     'production', 'work_order_routing', 'location_id', 'Column production.work_order_routing.location_id should be NOT NULL');
SELECT col_hasnt_default('production', 'work_order_routing', 'location_id', 'Column production.work_order_routing.location_id should not have a default');

SELECT has_column(       'production', 'work_order_routing', 'scheduled_start_date', 'Column production.work_order_routing.scheduled_start_date should exist');
SELECT col_type_is(      'production', 'work_order_routing', 'scheduled_start_date', 'timestamp without time zone', 'Column production.work_order_routing.scheduled_start_date should be type timestamp without time zone');
SELECT col_not_null(     'production', 'work_order_routing', 'scheduled_start_date', 'Column production.work_order_routing.scheduled_start_date should be NOT NULL');
SELECT col_hasnt_default('production', 'work_order_routing', 'scheduled_start_date', 'Column production.work_order_routing.scheduled_start_date should not have a default');

SELECT has_column(       'production', 'work_order_routing', 'scheduled_end_date', 'Column production.work_order_routing.scheduled_end_date should exist');
SELECT col_type_is(      'production', 'work_order_routing', 'scheduled_end_date', 'timestamp without time zone', 'Column production.work_order_routing.scheduled_end_date should be type timestamp without time zone');
SELECT col_not_null(     'production', 'work_order_routing', 'scheduled_end_date', 'Column production.work_order_routing.scheduled_end_date should be NOT NULL');
SELECT col_hasnt_default('production', 'work_order_routing', 'scheduled_end_date', 'Column production.work_order_routing.scheduled_end_date should not have a default');

SELECT has_column(       'production', 'work_order_routing', 'actual_start_date', 'Column production.work_order_routing.actual_start_date should exist');
SELECT col_type_is(      'production', 'work_order_routing', 'actual_start_date', 'timestamp without time zone', 'Column production.work_order_routing.actual_start_date should be type timestamp without time zone');
SELECT col_is_null(      'production', 'work_order_routing', 'actual_start_date', 'Column production.work_order_routing.actual_start_date should allow NULL');
SELECT col_hasnt_default('production', 'work_order_routing', 'actual_start_date', 'Column production.work_order_routing.actual_start_date should not have a default');

SELECT has_column(       'production', 'work_order_routing', 'actual_end_date', 'Column production.work_order_routing.actual_end_date should exist');
SELECT col_type_is(      'production', 'work_order_routing', 'actual_end_date', 'timestamp without time zone', 'Column production.work_order_routing.actual_end_date should be type timestamp without time zone');
SELECT col_is_null(      'production', 'work_order_routing', 'actual_end_date', 'Column production.work_order_routing.actual_end_date should allow NULL');
SELECT col_hasnt_default('production', 'work_order_routing', 'actual_end_date', 'Column production.work_order_routing.actual_end_date should not have a default');

SELECT has_column(       'production', 'work_order_routing', 'actual_resource_hrs', 'Column production.work_order_routing.actual_resource_hrs should exist');
SELECT col_type_is(      'production', 'work_order_routing', 'actual_resource_hrs', 'numeric(9,4)', 'Column production.work_order_routing.actual_resource_hrs should be type numeric(9,4)');
SELECT col_is_null(      'production', 'work_order_routing', 'actual_resource_hrs', 'Column production.work_order_routing.actual_resource_hrs should allow NULL');
SELECT col_hasnt_default('production', 'work_order_routing', 'actual_resource_hrs', 'Column production.work_order_routing.actual_resource_hrs should not have a default');

SELECT has_column(       'production', 'work_order_routing', 'planned_cost', 'Column production.work_order_routing.planned_cost should exist');
SELECT col_type_is(      'production', 'work_order_routing', 'planned_cost', 'numeric', 'Column production.work_order_routing.planned_cost should be type numeric');
SELECT col_not_null(     'production', 'work_order_routing', 'planned_cost', 'Column production.work_order_routing.planned_cost should be NOT NULL');
SELECT col_hasnt_default('production', 'work_order_routing', 'planned_cost', 'Column production.work_order_routing.planned_cost should not have a default');

SELECT has_column(       'production', 'work_order_routing', 'actual_cost', 'Column production.work_order_routing.actual_cost should exist');
SELECT col_type_is(      'production', 'work_order_routing', 'actual_cost', 'numeric', 'Column production.work_order_routing.actual_cost should be type numeric');
SELECT col_is_null(      'production', 'work_order_routing', 'actual_cost', 'Column production.work_order_routing.actual_cost should allow NULL');
SELECT col_hasnt_default('production', 'work_order_routing', 'actual_cost', 'Column production.work_order_routing.actual_cost should not have a default');

SELECT has_column(       'production', 'work_order_routing', 'modified_date', 'Column production.work_order_routing.modified_date should exist');
SELECT col_type_is(      'production', 'work_order_routing', 'modified_date', 'timestamp without time zone', 'Column production.work_order_routing.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'production', 'work_order_routing', 'modified_date', 'Column production.work_order_routing.modified_date should be NOT NULL');
SELECT col_has_default(  'production', 'work_order_routing', 'modified_date', 'Column production.work_order_routing.modified_date should have a default');
SELECT col_default_is(   'production', 'work_order_routing', 'modified_date', 'timezone(''utc''::text, now())', 'Column production.work_order_routing.modified_date default is');

SELECT * FROM finish();
ROLLBACK;
