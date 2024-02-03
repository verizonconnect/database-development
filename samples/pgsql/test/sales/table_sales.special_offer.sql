SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(58);

SELECT has_table(
    'sales', 'special_offer',
    'Should have table sales.special_offer'
);

SELECT has_pk(
    'sales', 'special_offer',
    'Table sales.special_offer should have a primary key'
);

SELECT has_check(
    'sales', 'special_offer',
    'Table sales.special_offer should have check contraint(s)'
);

SELECT col_is_pk('sales'::name, 'special_offer'::name, ARRAY[
    'special_offer_id'::name
],
'Primary key definition is not as expected');

SELECT columns_are('sales'::name, 'special_offer'::name, ARRAY[
    'special_offer_id'::name,
    'description'::name,
    'discount_pct'::name,
    'type'::name,
    'category'::name,
    'start_date'::name,
    'end_date'::name,
    'min_qty'::name,
    'max_qty'::name,
    'rowguid'::name,
    'modified_date'::name
]);

SELECT has_column(       'sales', 'special_offer', 'special_offer_id', 'Column sales.special_offer.special_offer_id should exist');
SELECT col_type_is(      'sales', 'special_offer', 'special_offer_id', 'integer', 'Column sales.special_offer.special_offer_id should be type integer');
SELECT col_not_null(     'sales', 'special_offer', 'special_offer_id', 'Column sales.special_offer.special_offer_id should be NOT NULL');
SELECT col_has_default(  'sales', 'special_offer', 'special_offer_id', 'Column sales.special_offer.special_offer_id should have a default');
SELECT col_default_is(   'sales', 'special_offer', 'special_offer_id', 'nextval(''sales.special_offer_special_offer_id_seq''::regclass)', 'Column sales.special_offer.special_offer_id default is');

SELECT has_column(       'sales', 'special_offer', 'description', 'Column sales.special_offer.description should exist');
SELECT col_type_is(      'sales', 'special_offer', 'description', 'character varying(255)', 'Column sales.special_offer.description should be type character varying(255)');
SELECT col_not_null(     'sales', 'special_offer', 'description', 'Column sales.special_offer.description should be NOT NULL');
SELECT col_hasnt_default('sales', 'special_offer', 'description', 'Column sales.special_offer.description should not have a default');

SELECT has_column(       'sales', 'special_offer', 'discount_pct', 'Column sales.special_offer.discount_pct should exist');
SELECT col_type_is(      'sales', 'special_offer', 'discount_pct', 'numeric', 'Column sales.special_offer.discount_pct should be type numeric');
SELECT col_not_null(     'sales', 'special_offer', 'discount_pct', 'Column sales.special_offer.discount_pct should be NOT NULL');
SELECT col_has_default(  'sales', 'special_offer', 'discount_pct', 'Column sales.special_offer.discount_pct should have a default');
SELECT col_default_is(   'sales', 'special_offer', 'discount_pct', '0.00', 'Column sales.special_offer.discount_pct default is');
SELECT col_has_check(    'sales', 'special_offer', 'discount_pct', 'Column sales.special_offer.discount_pct should have a check constraint');

SELECT has_column(       'sales', 'special_offer', 'type', 'Column sales.special_offer.type should exist');
SELECT col_type_is(      'sales', 'special_offer', 'type', 'character varying(50)', 'Column sales.special_offer.type should be type character varying(50)');
SELECT col_not_null(     'sales', 'special_offer', 'type', 'Column sales.special_offer.type should be NOT NULL');
SELECT col_hasnt_default('sales', 'special_offer', 'type', 'Column sales.special_offer.type should not have a default');

SELECT has_column(       'sales', 'special_offer', 'category', 'Column sales.special_offer.category should exist');
SELECT col_type_is(      'sales', 'special_offer', 'category', 'character varying(50)', 'Column sales.special_offer.category should be type character varying(50)');
SELECT col_not_null(     'sales', 'special_offer', 'category', 'Column sales.special_offer.category should be NOT NULL');
SELECT col_hasnt_default('sales', 'special_offer', 'category', 'Column sales.special_offer.category should not have a default');

SELECT has_column(       'sales', 'special_offer', 'start_date', 'Column sales.special_offer.start_date should exist');
SELECT col_type_is(      'sales', 'special_offer', 'start_date', 'timestamp without time zone', 'Column sales.special_offer.start_date should be type timestamp without time zone');
SELECT col_not_null(     'sales', 'special_offer', 'start_date', 'Column sales.special_offer.start_date should be NOT NULL');
SELECT col_hasnt_default('sales', 'special_offer', 'start_date', 'Column sales.special_offer.start_date should not have a default');

SELECT has_column(       'sales', 'special_offer', 'end_date', 'Column sales.special_offer.end_date should exist');
SELECT col_type_is(      'sales', 'special_offer', 'end_date', 'timestamp without time zone', 'Column sales.special_offer.end_date should be type timestamp without time zone');
SELECT col_not_null(     'sales', 'special_offer', 'end_date', 'Column sales.special_offer.end_date should be NOT NULL');
SELECT col_hasnt_default('sales', 'special_offer', 'end_date', 'Column sales.special_offer.end_date should not have a default');
SELECT col_has_check(    'sales', 'special_offer', ARRAY['end_date'::name,'start_date'::name], 'Columns sales.special_offer.[end_date,start_date] should have a check constraint');

SELECT has_column(       'sales', 'special_offer', 'min_qty', 'Column sales.special_offer.min_qty should exist');
SELECT col_type_is(      'sales', 'special_offer', 'min_qty', 'integer', 'Column sales.special_offer.min_qty should be type integer');
SELECT col_not_null(     'sales', 'special_offer', 'min_qty', 'Column sales.special_offer.min_qty should be NOT NULL');
SELECT col_has_default(  'sales', 'special_offer', 'min_qty', 'Column sales.special_offer.min_qty should have a default');
SELECT col_default_is(   'sales', 'special_offer', 'min_qty', '0', 'Column sales.special_offer.min_qty default is');
SELECT col_has_check(    'sales', 'special_offer', 'min_qty', 'Column sales.special_offer.min_qty should have a check constraint');

SELECT has_column(       'sales', 'special_offer', 'max_qty', 'Column sales.special_offer.max_qty should exist');
SELECT col_type_is(      'sales', 'special_offer', 'max_qty', 'integer', 'Column sales.special_offer.max_qty should be type integer');
SELECT col_is_null(      'sales', 'special_offer', 'max_qty', 'Column sales.special_offer.max_qty should allow NULL');
SELECT col_hasnt_default('sales', 'special_offer', 'max_qty', 'Column sales.special_offer.max_qty should not have a default');
SELECT col_has_check(    'sales', 'special_offer', 'max_qty', 'Column sales.special_offer.max_qty should have a check constraint');

SELECT has_column(       'sales', 'special_offer', 'rowguid', 'Column sales.special_offer.rowguid should exist');
SELECT col_type_is(      'sales', 'special_offer', 'rowguid', 'uuid', 'Column sales.special_offer.rowguid should be type uuid');
SELECT col_not_null(     'sales', 'special_offer', 'rowguid', 'Column sales.special_offer.rowguid should be NOT NULL');
SELECT col_has_default(  'sales', 'special_offer', 'rowguid', 'Column sales.special_offer.rowguid should have a default');
SELECT col_default_is(   'sales', 'special_offer', 'rowguid', 'common.uuid_generate_v1()', 'Column sales.special_offer.rowguid default is');

SELECT has_column(       'sales', 'special_offer', 'modified_date', 'Column sales.special_offer.modified_date should exist');
SELECT col_type_is(      'sales', 'special_offer', 'modified_date', 'timestamp without time zone', 'Column sales.special_offer.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'sales', 'special_offer', 'modified_date', 'Column sales.special_offer.modified_date should be NOT NULL');
SELECT col_has_default(  'sales', 'special_offer', 'modified_date', 'Column sales.special_offer.modified_date should have a default');
SELECT col_default_is(   'sales', 'special_offer', 'modified_date', 'timezone(''utc''::text, now())', 'Column sales.special_offer.modified_date default is');

SELECT * FROM finish();
ROLLBACK;

