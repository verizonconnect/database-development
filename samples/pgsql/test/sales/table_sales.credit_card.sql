SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(29);

SELECT has_table(
    'sales', 'credit_card',
    'Should have table sales.credit_card'
);

SELECT hasnt_pk(
    'sales', 'credit_card',
    'Table sales.credit_card should have a primary key'
);

SELECT columns_are('sales'::name, 'credit_card'::name, ARRAY[
    'credit_card_id'::name,
    'card_type'::name,
    'card_number'::name,
    'exp_month'::name,
    'exp_year'::name,
    'modified_date'::name
]);

SELECT has_column(       'sales', 'credit_card', 'credit_card_id', 'Column sales.credit_card.credit_card_id should exist');
SELECT col_type_is(      'sales', 'credit_card', 'credit_card_id', 'integer', 'Column sales.credit_card.credit_card_id should be type integer');
SELECT col_not_null(     'sales', 'credit_card', 'credit_card_id', 'Column sales.credit_card.credit_card_id should be NOT NULL');
SELECT col_has_default(  'sales', 'credit_card', 'credit_card_id', 'Column sales.credit_card.credit_card_id should have a default');
SELECT col_default_is(   'sales', 'credit_card', 'credit_card_id', 'nextval(''sales.credit_card_credit_card_id_seq''::regclass)', 'Column sales.credit_card.credit_card_id default is');

SELECT has_column(       'sales', 'credit_card', 'card_type', 'Column sales.credit_card.card_type should exist');
SELECT col_type_is(      'sales', 'credit_card', 'card_type', 'character varying(50)', 'Column sales.credit_card.card_type should be type character varying(50)');
SELECT col_not_null(     'sales', 'credit_card', 'card_type', 'Column sales.credit_card.card_type should be NOT NULL');
SELECT col_hasnt_default('sales', 'credit_card', 'card_type', 'Column sales.credit_card.card_type should not have a default');

SELECT has_column(       'sales', 'credit_card', 'card_number', 'Column sales.credit_card.card_number should exist');
SELECT col_type_is(      'sales', 'credit_card', 'card_number', 'character varying(25)', 'Column sales.credit_card.card_number should be type character varying(25)');
SELECT col_not_null(     'sales', 'credit_card', 'card_number', 'Column sales.credit_card.card_number should be NOT NULL');
SELECT col_hasnt_default('sales', 'credit_card', 'card_number', 'Column sales.credit_card.card_number should not have a default');

SELECT has_column(       'sales', 'credit_card', 'exp_month', 'Column sales.credit_card.exp_month should exist');
SELECT col_type_is(      'sales', 'credit_card', 'exp_month', 'smallint', 'Column sales.credit_card.exp_month should be type smallint');
SELECT col_not_null(     'sales', 'credit_card', 'exp_month', 'Column sales.credit_card.exp_month should be NOT NULL');
SELECT col_hasnt_default('sales', 'credit_card', 'exp_month', 'Column sales.credit_card.exp_month should not have a default');

SELECT has_column(       'sales', 'credit_card', 'exp_year', 'Column sales.credit_card.exp_year should exist');
SELECT col_type_is(      'sales', 'credit_card', 'exp_year', 'smallint', 'Column sales.credit_card.exp_year should be type smallint');
SELECT col_not_null(     'sales', 'credit_card', 'exp_year', 'Column sales.credit_card.exp_year should be NOT NULL');
SELECT col_hasnt_default('sales', 'credit_card', 'exp_year', 'Column sales.credit_card.exp_year should not have a default');

SELECT has_column(       'sales', 'credit_card', 'modified_date', 'Column sales.credit_card.modified_date should exist');
SELECT col_type_is(      'sales', 'credit_card', 'modified_date', 'timestamp without time zone', 'Column sales.credit_card.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'sales', 'credit_card', 'modified_date', 'Column sales.credit_card.modified_date should be NOT NULL');
SELECT col_has_default(  'sales', 'credit_card', 'modified_date', 'Column sales.credit_card.modified_date should have a default');
SELECT col_default_is(   'sales', 'credit_card', 'modified_date', 'timezone(''utc''::text, now())', 'Column sales.credit_card.modified_date default is');

SELECT * FROM finish();
ROLLBACK;
