SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(49);

SELECT has_table(
    'production', 'bill_of_materials',
    'Should have table production.bill_of_materials'
);

SELECT has_pk(
    'production', 'bill_of_materials',
    'Table production.bill_of_materials should have a primary key'
);

SELECT has_check(
    'production', 'bill_of_materials',
    'Table production.bill_of_materials should have check contraint(s)'
);

SELECT col_is_pk('production'::name, 'bill_of_materials'::name, ARRAY[
    'bill_of_materials_id'::name
],
'Primary key definition is not as expected');

SELECT columns_are('production'::name, 'bill_of_materials'::name, ARRAY[
    'bill_of_materials_id'::name,
    'product_assembly_id'::name,
    'component_id'::name,
    'start_date'::name,
    'end_date'::name,
    'unit_measure_code'::name,
    'bom_level'::name,
    'per_assembly_qty'::name,
    'modified_date'::name
]);

SELECT has_column(       'production', 'bill_of_materials', 'bill_of_materials_id', 'Column production.bill_of_materials.bill_of_materials_id should exist');
SELECT col_type_is(      'production', 'bill_of_materials', 'bill_of_materials_id', 'integer', 'Column production.bill_of_materials.bill_of_materials_id should be type integer');
SELECT col_not_null(     'production', 'bill_of_materials', 'bill_of_materials_id', 'Column production.bill_of_materials.bill_of_materials_id should be NOT NULL');
SELECT col_has_default(  'production', 'bill_of_materials', 'bill_of_materials_id', 'Column production.bill_of_materials.bill_of_materials_id should have a default');
SELECT col_default_is(   'production', 'bill_of_materials', 'bill_of_materials_id', 'nextval(''production.bill_of_materials_bill_of_materials_id_seq''::regclass)', 'Column production.bill_of_materials.bill_of_materials_id default is');

SELECT has_column(       'production', 'bill_of_materials', 'product_assembly_id', 'Column production.bill_of_materials.product_assembly_id should exist');
SELECT col_type_is(      'production', 'bill_of_materials', 'product_assembly_id', 'integer', 'Column production.bill_of_materials.product_assembly_id should be type integer');
SELECT col_is_null(      'production', 'bill_of_materials', 'product_assembly_id', 'Column production.bill_of_materials.product_assembly_id should allow NULL');
SELECT col_hasnt_default('production', 'bill_of_materials', 'product_assembly_id', 'Column production.bill_of_materials.product_assembly_id should not have a default');
SELECT col_has_check(    'production', 'bill_of_materials', ARRAY['product_assembly_id'::name,'component_id'::name], 'Columns production.bill_of_materials.[product_assembly_id,component_id] should have a check constraint');

SELECT has_column(       'production', 'bill_of_materials', 'component_id', 'Column production.bill_of_materials.component_id should exist');
SELECT col_type_is(      'production', 'bill_of_materials', 'component_id', 'integer', 'Column production.bill_of_materials.component_id should be type integer');
SELECT col_not_null(     'production', 'bill_of_materials', 'component_id', 'Column production.bill_of_materials.component_id should be NOT NULL');
SELECT col_hasnt_default('production', 'bill_of_materials', 'component_id', 'Column production.bill_of_materials.component_id should not have a default');

SELECT has_column(       'production', 'bill_of_materials', 'start_date', 'Column production.bill_of_materials.start_date should exist');
SELECT col_type_is(      'production', 'bill_of_materials', 'start_date', 'timestamp without time zone', 'Column production.bill_of_materials.start_date should be type timestamp without time zone');
SELECT col_not_null(     'production', 'bill_of_materials', 'start_date', 'Column production.bill_of_materials.start_date should be NOT NULL');
SELECT col_has_default(  'production', 'bill_of_materials', 'start_date', 'Column production.bill_of_materials.start_date should have a default');
SELECT col_default_is(   'production', 'bill_of_materials', 'start_date', 'timezone(''utc''::text, now())', 'Column production.bill_of_materials.start_date default is');

SELECT has_column(       'production', 'bill_of_materials', 'end_date', 'Column production.bill_of_materials.end_date should exist');
SELECT col_type_is(      'production', 'bill_of_materials', 'end_date', 'timestamp without time zone', 'Column production.bill_of_materials.end_date should be type timestamp without time zone');
SELECT col_is_null(      'production', 'bill_of_materials', 'end_date', 'Column production.bill_of_materials.end_date should allow NULL');
SELECT col_hasnt_default('production', 'bill_of_materials', 'end_date', 'Column production.bill_of_materials.end_date should not have a default');
SELECT col_has_check(    'production', 'bill_of_materials', ARRAY['end_date'::name,'start_date'::name], 'Columns production.bill_of_materials.[end_date,start_date] should have a check constraint');

SELECT has_column(       'production', 'bill_of_materials', 'unit_measure_code', 'Column production.bill_of_materials.unit_measure_code should exist');
SELECT col_type_is(      'production', 'bill_of_materials', 'unit_measure_code', 'character(3)', 'Column production.bill_of_materials.unit_measure_code should be type character(3)');
SELECT col_not_null(     'production', 'bill_of_materials', 'unit_measure_code', 'Column production.bill_of_materials.unit_measure_code should be NOT NULL');
SELECT col_hasnt_default('production', 'bill_of_materials', 'unit_measure_code', 'Column production.bill_of_materials.unit_measure_code should not have a default');

SELECT has_column(       'production', 'bill_of_materials', 'bom_level', 'Column production.bill_of_materials.bom_level should exist');
SELECT col_type_is(      'production', 'bill_of_materials', 'bom_level', 'smallint', 'Column production.bill_of_materials.bom_level should be type smallint');
SELECT col_not_null(     'production', 'bill_of_materials', 'bom_level', 'Column production.bill_of_materials.bom_level should be NOT NULL');
SELECT col_hasnt_default('production', 'bill_of_materials', 'bom_level', 'Column production.bill_of_materials.bom_level should not have a default');
SELECT col_has_check(    'production', 'bill_of_materials', ARRAY['product_assembly_id'::name,'bom_level'::name,'per_assembly_qty'::name], 'Columns production.bill_of_materials.[product_assembly_id,bom_level,per_assembly_qty] should have a check constraint');

SELECT has_column(       'production', 'bill_of_materials', 'per_assembly_qty', 'Column production.bill_of_materials.per_assembly_qty should exist');
SELECT col_type_is(      'production', 'bill_of_materials', 'per_assembly_qty', 'numeric(8,2)', 'Column production.bill_of_materials.per_assembly_qty should be type numeric(8,2)');
SELECT col_not_null(     'production', 'bill_of_materials', 'per_assembly_qty', 'Column production.bill_of_materials.per_assembly_qty should be NOT NULL');
SELECT col_has_default(  'production', 'bill_of_materials', 'per_assembly_qty', 'Column production.bill_of_materials.per_assembly_qty should have a default');
SELECT col_default_is(   'production', 'bill_of_materials', 'per_assembly_qty', '1.00', 'Column production.bill_of_materials.per_assembly_qty default is');
SELECT col_has_check(    'production', 'bill_of_materials', 'per_assembly_qty', 'Column production.bill_of_materials.per_assembly_qty should have a check constraint');

SELECT has_column(       'production', 'bill_of_materials', 'modified_date', 'Column production.bill_of_materials.modified_date should exist');
SELECT col_type_is(      'production', 'bill_of_materials', 'modified_date', 'timestamp without time zone', 'Column production.bill_of_materials.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'production', 'bill_of_materials', 'modified_date', 'Column production.bill_of_materials.modified_date should be NOT NULL');
SELECT col_has_default(  'production', 'bill_of_materials', 'modified_date', 'Column production.bill_of_materials.modified_date should have a default');
SELECT col_default_is(   'production', 'bill_of_materials', 'modified_date', 'timezone(''utc''::text, now())', 'Column production.bill_of_materials.modified_date default is');

SELECT * FROM finish();
ROLLBACK;

