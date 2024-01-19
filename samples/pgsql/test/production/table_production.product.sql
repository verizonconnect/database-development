SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(108);

SELECT has_table(
    'production', 'product',
    'Should have table production.product'
);

SELECT hasnt_pk(
    'production', 'product',
    'Table production.product should have a primary key'
);

SELECT columns_are('production'::name, 'product'::name, ARRAY[
    'product_id'::name,
    'name'::name,
    'product_number'::name,
    'make_flag'::name,
    'finished_goods_flag'::name,
    'colour'::name,
    'safety_stock_level'::name,
    'reorder_point'::name,
    'standard_cost'::name,
    'list_price'::name,
    'size'::name,
    'size_unit_measure_code'::name,
    'weight_unit_measure_code'::name,
    'weight'::name,
    'days_to_manufacture'::name,
    'product_line'::name,
    'class'::name,
    'style'::name,
    'product_sub_category_id'::name,
    'product_model_id'::name,
    'sell_start_date'::name,
    'sell_end_date'::name,
    'discontinued_date'::name,
    'rowguid'::name,
    'modified_date'::name
]);

SELECT has_column(       'production', 'product', 'product_id', 'Column production.product.product_id should exist');
SELECT col_type_is(      'production', 'product', 'product_id', 'integer', 'Column production.product.product_id should be type integer');
SELECT col_not_null(     'production', 'product', 'product_id', 'Column production.product.product_id should be NOT NULL');
SELECT col_has_default(  'production', 'product', 'product_id', 'Column production.product.product_id should have a default');
SELECT col_default_is(   'production', 'product', 'product_id', 'nextval(''production.product_product_id_seq''::regclass)', 'Column production.product.product_id default is');

SELECT has_column(       'production', 'product', 'name', 'Column production.product.name should exist');
SELECT col_type_is(      'production', 'product', 'name', 'common.name', 'Column production.product.name should be type common.name');
SELECT col_not_null(     'production', 'product', 'name', 'Column production.product.name should be NOT NULL');
SELECT col_hasnt_default('production', 'product', 'name', 'Column production.product.name should not have a default');

SELECT has_column(       'production', 'product', 'product_number', 'Column production.product.product_number should exist');
SELECT col_type_is(      'production', 'product', 'product_number', 'character varying(25)', 'Column production.product.product_number should be type character varying(25)');
SELECT col_not_null(     'production', 'product', 'product_number', 'Column production.product.product_number should be NOT NULL');
SELECT col_hasnt_default('production', 'product', 'product_number', 'Column production.product.product_number should not have a default');

SELECT has_column(       'production', 'product', 'make_flag', 'Column production.product.make_flag should exist');
SELECT col_type_is(      'production', 'product', 'make_flag', 'common.flag', 'Column production.product.make_flag should be type common.flag');
SELECT col_not_null(     'production', 'product', 'make_flag', 'Column production.product.make_flag should be NOT NULL');
SELECT col_has_default(  'production', 'product', 'make_flag', 'Column production.product.make_flag should have a default');
SELECT col_default_is(   'production', 'product', 'make_flag', 'true', 'Column production.product.make_flag default is');

SELECT has_column(       'production', 'product', 'finished_goods_flag', 'Column production.product.finished_goods_flag should exist');
SELECT col_type_is(      'production', 'product', 'finished_goods_flag', 'common.flag', 'Column production.product.finished_goods_flag should be type common.flag');
SELECT col_not_null(     'production', 'product', 'finished_goods_flag', 'Column production.product.finished_goods_flag should be NOT NULL');
SELECT col_has_default(  'production', 'product', 'finished_goods_flag', 'Column production.product.finished_goods_flag should have a default');
SELECT col_default_is(   'production', 'product', 'finished_goods_flag', 'true', 'Column production.product.finished_goods_flag default is');

SELECT has_column(       'production', 'product', 'colour', 'Column production.product.colour should exist');
SELECT col_type_is(      'production', 'product', 'colour', 'character varying(15)', 'Column production.product.colour should be type character varying(15)');
SELECT col_is_null(      'production', 'product', 'colour', 'Column production.product.colour should allow NULL');
SELECT col_hasnt_default('production', 'product', 'colour', 'Column production.product.colour should not have a default');

SELECT has_column(       'production', 'product', 'safety_stock_level', 'Column production.product.safety_stock_level should exist');
SELECT col_type_is(      'production', 'product', 'safety_stock_level', 'smallint', 'Column production.product.safety_stock_level should be type smallint');
SELECT col_not_null(     'production', 'product', 'safety_stock_level', 'Column production.product.safety_stock_level should be NOT NULL');
SELECT col_hasnt_default('production', 'product', 'safety_stock_level', 'Column production.product.safety_stock_level should not have a default');

SELECT has_column(       'production', 'product', 'reorder_point', 'Column production.product.reorder_point should exist');
SELECT col_type_is(      'production', 'product', 'reorder_point', 'smallint', 'Column production.product.reorder_point should be type smallint');
SELECT col_not_null(     'production', 'product', 'reorder_point', 'Column production.product.reorder_point should be NOT NULL');
SELECT col_hasnt_default('production', 'product', 'reorder_point', 'Column production.product.reorder_point should not have a default');

SELECT has_column(       'production', 'product', 'standard_cost', 'Column production.product.standard_cost should exist');
SELECT col_type_is(      'production', 'product', 'standard_cost', 'numeric', 'Column production.product.standard_cost should be type numeric');
SELECT col_not_null(     'production', 'product', 'standard_cost', 'Column production.product.standard_cost should be NOT NULL');
SELECT col_hasnt_default('production', 'product', 'standard_cost', 'Column production.product.standard_cost should not have a default');

SELECT has_column(       'production', 'product', 'list_price', 'Column production.product.list_price should exist');
SELECT col_type_is(      'production', 'product', 'list_price', 'numeric', 'Column production.product.list_price should be type numeric');
SELECT col_not_null(     'production', 'product', 'list_price', 'Column production.product.list_price should be NOT NULL');
SELECT col_hasnt_default('production', 'product', 'list_price', 'Column production.product.list_price should not have a default');

SELECT has_column(       'production', 'product', 'size', 'Column production.product.size should exist');
SELECT col_type_is(      'production', 'product', 'size', 'character varying(5)', 'Column production.product.size should be type character varying(5)');
SELECT col_is_null(      'production', 'product', 'size', 'Column production.product.size should allow NULL');
SELECT col_hasnt_default('production', 'product', 'size', 'Column production.product.size should not have a default');

SELECT has_column(       'production', 'product', 'size_unit_measure_code', 'Column production.product.size_unit_measure_code should exist');
SELECT col_type_is(      'production', 'product', 'size_unit_measure_code', 'character(3)', 'Column production.product.size_unit_measure_code should be type character(3)');
SELECT col_is_null(      'production', 'product', 'size_unit_measure_code', 'Column production.product.size_unit_measure_code should allow NULL');
SELECT col_hasnt_default('production', 'product', 'size_unit_measure_code', 'Column production.product.size_unit_measure_code should not have a default');

SELECT has_column(       'production', 'product', 'weight_unit_measure_code', 'Column production.product.weight_unit_measure_code should exist');
SELECT col_type_is(      'production', 'product', 'weight_unit_measure_code', 'character(3)', 'Column production.product.weight_unit_measure_code should be type character(3)');
SELECT col_is_null(      'production', 'product', 'weight_unit_measure_code', 'Column production.product.weight_unit_measure_code should allow NULL');
SELECT col_hasnt_default('production', 'product', 'weight_unit_measure_code', 'Column production.product.weight_unit_measure_code should not have a default');

SELECT has_column(       'production', 'product', 'weight', 'Column production.product.weight should exist');
SELECT col_type_is(      'production', 'product', 'weight', 'numeric(8,2)', 'Column production.product.weight should be type numeric(8,2)');
SELECT col_is_null(      'production', 'product', 'weight', 'Column production.product.weight should allow NULL');
SELECT col_hasnt_default('production', 'product', 'weight', 'Column production.product.weight should not have a default');

SELECT has_column(       'production', 'product', 'days_to_manufacture', 'Column production.product.days_to_manufacture should exist');
SELECT col_type_is(      'production', 'product', 'days_to_manufacture', 'integer', 'Column production.product.days_to_manufacture should be type integer');
SELECT col_not_null(     'production', 'product', 'days_to_manufacture', 'Column production.product.days_to_manufacture should be NOT NULL');
SELECT col_hasnt_default('production', 'product', 'days_to_manufacture', 'Column production.product.days_to_manufacture should not have a default');

SELECT has_column(       'production', 'product', 'product_line', 'Column production.product.product_line should exist');
SELECT col_type_is(      'production', 'product', 'product_line', 'character(2)', 'Column production.product.product_line should be type character(2)');
SELECT col_is_null(      'production', 'product', 'product_line', 'Column production.product.product_line should allow NULL');
SELECT col_hasnt_default('production', 'product', 'product_line', 'Column production.product.product_line should not have a default');

SELECT has_column(       'production', 'product', 'class', 'Column production.product.class should exist');
SELECT col_type_is(      'production', 'product', 'class', 'character(2)', 'Column production.product.class should be type character(2)');
SELECT col_is_null(      'production', 'product', 'class', 'Column production.product.class should allow NULL');
SELECT col_hasnt_default('production', 'product', 'class', 'Column production.product.class should not have a default');

SELECT has_column(       'production', 'product', 'style', 'Column production.product.style should exist');
SELECT col_type_is(      'production', 'product', 'style', 'character(2)', 'Column production.product.style should be type character(2)');
SELECT col_is_null(      'production', 'product', 'style', 'Column production.product.style should allow NULL');
SELECT col_hasnt_default('production', 'product', 'style', 'Column production.product.style should not have a default');

SELECT has_column(       'production', 'product', 'product_sub_category_id', 'Column production.product.product_sub_category_id should exist');
SELECT col_type_is(      'production', 'product', 'product_sub_category_id', 'integer', 'Column production.product.product_sub_category_id should be type integer');
SELECT col_is_null(      'production', 'product', 'product_sub_category_id', 'Column production.product.product_sub_category_id should allow NULL');
SELECT col_hasnt_default('production', 'product', 'product_sub_category_id', 'Column production.product.product_sub_category_id should not have a default');

SELECT has_column(       'production', 'product', 'product_model_id', 'Column production.product.product_model_id should exist');
SELECT col_type_is(      'production', 'product', 'product_model_id', 'integer', 'Column production.product.product_model_id should be type integer');
SELECT col_is_null(      'production', 'product', 'product_model_id', 'Column production.product.product_model_id should allow NULL');
SELECT col_hasnt_default('production', 'product', 'product_model_id', 'Column production.product.product_model_id should not have a default');

SELECT has_column(       'production', 'product', 'sell_start_date', 'Column production.product.sell_start_date should exist');
SELECT col_type_is(      'production', 'product', 'sell_start_date', 'timestamp without time zone', 'Column production.product.sell_start_date should be type timestamp without time zone');
SELECT col_not_null(     'production', 'product', 'sell_start_date', 'Column production.product.sell_start_date should be NOT NULL');
SELECT col_hasnt_default('production', 'product', 'sell_start_date', 'Column production.product.sell_start_date should not have a default');

SELECT has_column(       'production', 'product', 'sell_end_date', 'Column production.product.sell_end_date should exist');
SELECT col_type_is(      'production', 'product', 'sell_end_date', 'timestamp without time zone', 'Column production.product.sell_end_date should be type timestamp without time zone');
SELECT col_is_null(      'production', 'product', 'sell_end_date', 'Column production.product.sell_end_date should allow NULL');
SELECT col_hasnt_default('production', 'product', 'sell_end_date', 'Column production.product.sell_end_date should not have a default');

SELECT has_column(       'production', 'product', 'discontinued_date', 'Column production.product.discontinued_date should exist');
SELECT col_type_is(      'production', 'product', 'discontinued_date', 'timestamp without time zone', 'Column production.product.discontinued_date should be type timestamp without time zone');
SELECT col_is_null(      'production', 'product', 'discontinued_date', 'Column production.product.discontinued_date should allow NULL');
SELECT col_hasnt_default('production', 'product', 'discontinued_date', 'Column production.product.discontinued_date should not have a default');

SELECT has_column(       'production', 'product', 'rowguid', 'Column production.product.rowguid should exist');
SELECT col_type_is(      'production', 'product', 'rowguid', 'uuid', 'Column production.product.rowguid should be type uuid');
SELECT col_not_null(     'production', 'product', 'rowguid', 'Column production.product.rowguid should be NOT NULL');
SELECT col_has_default(  'production', 'product', 'rowguid', 'Column production.product.rowguid should have a default');
SELECT col_default_is(   'production', 'product', 'rowguid', 'common.uuid_generate_v1()', 'Column production.product.rowguid default is');

SELECT has_column(       'production', 'product', 'modified_date', 'Column production.product.modified_date should exist');
SELECT col_type_is(      'production', 'product', 'modified_date', 'timestamp without time zone', 'Column production.product.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'production', 'product', 'modified_date', 'Column production.product.modified_date should be NOT NULL');
SELECT col_has_default(  'production', 'product', 'modified_date', 'Column production.product.modified_date should have a default');
SELECT col_default_is(   'production', 'product', 'modified_date', 'timezone(''utc''::text, now())', 'Column production.product.modified_date default is');

SELECT * FROM finish();
ROLLBACK;
