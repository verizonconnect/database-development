SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(38);

SELECT has_table(
    'production', 'product_review',
    'Should have table production.product_review'
);

SELECT hasnt_pk(
    'production', 'product_review',
    'Table production.product_review should have a primary key'
);

SELECT columns_are('production'::name, 'product_review'::name, ARRAY[
    'product_review_id'::name,
    'product_id'::name,
    'reviewer_name'::name,
    'review_date'::name,
    'email_address'::name,
    'rating'::name,
    'comments'::name,
    'modified_date'::name
]);

SELECT has_column(       'production', 'product_review', 'product_review_id', 'Column production.product_review.product_review_id should exist');
SELECT col_type_is(      'production', 'product_review', 'product_review_id', 'integer', 'Column production.product_review.product_review_id should be type integer');
SELECT col_not_null(     'production', 'product_review', 'product_review_id', 'Column production.product_review.product_review_id should be NOT NULL');
SELECT col_has_default(  'production', 'product_review', 'product_review_id', 'Column production.product_review.product_review_id should have a default');
SELECT col_default_is(   'production', 'product_review', 'product_review_id', 'nextval(''production.product_review_product_review_id_seq''::regclass)', 'Column production.product_review.product_review_id default is');

SELECT has_column(       'production', 'product_review', 'product_id', 'Column production.product_review.product_id should exist');
SELECT col_type_is(      'production', 'product_review', 'product_id', 'integer', 'Column production.product_review.product_id should be type integer');
SELECT col_not_null(     'production', 'product_review', 'product_id', 'Column production.product_review.product_id should be NOT NULL');
SELECT col_hasnt_default('production', 'product_review', 'product_id', 'Column production.product_review.product_id should not have a default');

SELECT has_column(       'production', 'product_review', 'reviewer_name', 'Column production.product_review.reviewer_name should exist');
SELECT col_type_is(      'production', 'product_review', 'reviewer_name', 'common.name', 'Column production.product_review.reviewer_name should be type common.name');
SELECT col_not_null(     'production', 'product_review', 'reviewer_name', 'Column production.product_review.reviewer_name should be NOT NULL');
SELECT col_hasnt_default('production', 'product_review', 'reviewer_name', 'Column production.product_review.reviewer_name should not have a default');

SELECT has_column(       'production', 'product_review', 'review_date', 'Column production.product_review.review_date should exist');
SELECT col_type_is(      'production', 'product_review', 'review_date', 'timestamp without time zone', 'Column production.product_review.review_date should be type timestamp without time zone');
SELECT col_not_null(     'production', 'product_review', 'review_date', 'Column production.product_review.review_date should be NOT NULL');
SELECT col_has_default(  'production', 'product_review', 'review_date', 'Column production.product_review.review_date should have a default');
SELECT col_default_is(   'production', 'product_review', 'review_date', 'timezone(''utc''::text, now())', 'Column production.product_review.review_date default is');

SELECT has_column(       'production', 'product_review', 'email_address', 'Column production.product_review.email_address should exist');
SELECT col_type_is(      'production', 'product_review', 'email_address', 'character varying(50)', 'Column production.product_review.email_address should be type character varying(50)');
SELECT col_not_null(     'production', 'product_review', 'email_address', 'Column production.product_review.email_address should be NOT NULL');
SELECT col_hasnt_default('production', 'product_review', 'email_address', 'Column production.product_review.email_address should not have a default');

SELECT has_column(       'production', 'product_review', 'rating', 'Column production.product_review.rating should exist');
SELECT col_type_is(      'production', 'product_review', 'rating', 'integer', 'Column production.product_review.rating should be type integer');
SELECT col_not_null(     'production', 'product_review', 'rating', 'Column production.product_review.rating should be NOT NULL');
SELECT col_hasnt_default('production', 'product_review', 'rating', 'Column production.product_review.rating should not have a default');

SELECT has_column(       'production', 'product_review', 'comments', 'Column production.product_review.comments should exist');
SELECT col_type_is(      'production', 'product_review', 'comments', 'character varying(3850)', 'Column production.product_review.comments should be type character varying(3850)');
SELECT col_is_null(      'production', 'product_review', 'comments', 'Column production.product_review.comments should allow NULL');
SELECT col_hasnt_default('production', 'product_review', 'comments', 'Column production.product_review.comments should not have a default');

SELECT has_column(       'production', 'product_review', 'modified_date', 'Column production.product_review.modified_date should exist');
SELECT col_type_is(      'production', 'product_review', 'modified_date', 'timestamp without time zone', 'Column production.product_review.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'production', 'product_review', 'modified_date', 'Column production.product_review.modified_date should be NOT NULL');
SELECT col_has_default(  'production', 'product_review', 'modified_date', 'Column production.product_review.modified_date should have a default');
SELECT col_default_is(   'production', 'product_review', 'modified_date', 'timezone(''utc''::text, now())', 'Column production.product_review.modified_date default is');

SELECT * FROM finish();
ROLLBACK;
