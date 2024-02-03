SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(18);

SELECT has_table(
    'production', 'product_document',
    'Should have table production.product_document'
);

SELECT has_pk(
    'production', 'product_document',
    'Table production.product_document should have a primary key'
);

SELECT col_is_pk('production'::name, 'product_document'::name, ARRAY[
    'product_id'::name,
    'document_node'::name
],
'Primary key definition is not as expected');

SELECT columns_are('production'::name, 'product_document'::name, ARRAY[
    'product_id'::name,
    'document_node'::name,
    'modified_date'::name
]);

SELECT has_column(       'production', 'product_document', 'product_id', 'Column production.product_document.product_id should exist');
SELECT col_type_is(      'production', 'product_document', 'product_id', 'integer', 'Column production.product_document.product_id should be type integer');
SELECT col_not_null(     'production', 'product_document', 'product_id', 'Column production.product_document.product_id should be NOT NULL');
SELECT col_hasnt_default('production', 'product_document', 'product_id', 'Column production.product_document.product_id should not have a default');

SELECT has_column(       'production', 'product_document', 'document_node', 'Column production.product_document.document_node should exist');
SELECT col_type_is(      'production', 'product_document', 'document_node', 'character varying', 'Column production.product_document.document_node should be type character varying');
SELECT col_not_null(     'production', 'product_document', 'document_node', 'Column production.product_document.document_node should be NOT NULL');
SELECT col_has_default(  'production', 'product_document', 'document_node', 'Column production.product_document.document_node should have a default');
SELECT col_default_is(   'production', 'product_document', 'document_node', '/'::character varying, 'Column production.product_document.document_node default is');

SELECT has_column(       'production', 'product_document', 'modified_date', 'Column production.product_document.modified_date should exist');
SELECT col_type_is(      'production', 'product_document', 'modified_date', 'timestamp without time zone', 'Column production.product_document.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'production', 'product_document', 'modified_date', 'Column production.product_document.modified_date should be NOT NULL');
SELECT col_has_default(  'production', 'product_document', 'modified_date', 'Column production.product_document.modified_date should have a default');
SELECT col_default_is(   'production', 'product_document', 'modified_date', 'timezone(''utc''::text, now())', 'Column production.product_document.modified_date default is');

SELECT * FROM finish();
ROLLBACK;

