SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(16);

SELECT has_table(
    'sales', 'person_credit_card',
    'Should have table sales.person_credit_card'
);

SELECT hasnt_pk(
    'sales', 'person_credit_card',
    'Table sales.person_credit_card should have a primary key'
);

SELECT columns_are('sales'::name, 'person_credit_card'::name, ARRAY[
    'business_entity_id'::name,
    'credit_card_id'::name,
    'modified_date'::name
]);

SELECT has_column(       'sales', 'person_credit_card', 'business_entity_id', 'Column sales.person_credit_card.business_entity_id should exist');
SELECT col_type_is(      'sales', 'person_credit_card', 'business_entity_id', 'integer', 'Column sales.person_credit_card.business_entity_id should be type integer');
SELECT col_not_null(     'sales', 'person_credit_card', 'business_entity_id', 'Column sales.person_credit_card.business_entity_id should be NOT NULL');
SELECT col_hasnt_default('sales', 'person_credit_card', 'business_entity_id', 'Column sales.person_credit_card.business_entity_id should not have a default');

SELECT has_column(       'sales', 'person_credit_card', 'credit_card_id', 'Column sales.person_credit_card.credit_card_id should exist');
SELECT col_type_is(      'sales', 'person_credit_card', 'credit_card_id', 'integer', 'Column sales.person_credit_card.credit_card_id should be type integer');
SELECT col_not_null(     'sales', 'person_credit_card', 'credit_card_id', 'Column sales.person_credit_card.credit_card_id should be NOT NULL');
SELECT col_hasnt_default('sales', 'person_credit_card', 'credit_card_id', 'Column sales.person_credit_card.credit_card_id should not have a default');

SELECT has_column(       'sales', 'person_credit_card', 'modified_date', 'Column sales.person_credit_card.modified_date should exist');
SELECT col_type_is(      'sales', 'person_credit_card', 'modified_date', 'timestamp without time zone', 'Column sales.person_credit_card.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'sales', 'person_credit_card', 'modified_date', 'Column sales.person_credit_card.modified_date should be NOT NULL');
SELECT col_has_default(  'sales', 'person_credit_card', 'modified_date', 'Column sales.person_credit_card.modified_date should have a default');
SELECT col_default_is(   'sales', 'person_credit_card', 'modified_date', 'timezone(''utc''::text, now())', 'Column sales.person_credit_card.modified_date default is');

SELECT * FROM finish();
ROLLBACK;
