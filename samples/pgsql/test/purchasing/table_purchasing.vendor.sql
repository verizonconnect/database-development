SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(41);

SELECT has_table(
    'purchasing', 'vendor',
    'Should have table purchasing.vendor'
);

SELECT has_pk(
    'purchasing', 'vendor',
    'Table purchasing.vendor should have a primary key'
);

SELECT has_check(
    'purchasing', 'vendor',
    'Table purchasing.vendor should have check contraint(s)'
);

SELECT col_is_pk('purchasing'::name, 'vendor'::name, ARRAY[
    'business_entity_id'::name
],
'Primary key definition is not as expected');

SELECT columns_are('purchasing'::name, 'vendor'::name, ARRAY[
    'business_entity_id'::name,
    'account_number'::name,
    'name'::name,
    'credit_rating'::name,
    'preferred_vendor_status'::name,
    'active_flag'::name,
    'purchasing_web_service_url'::name,
    'modified_date'::name
]);

SELECT has_column(       'purchasing', 'vendor', 'business_entity_id', 'Column purchasing.vendor.business_entity_id should exist');
SELECT col_type_is(      'purchasing', 'vendor', 'business_entity_id', 'integer', 'Column purchasing.vendor.business_entity_id should be type integer');
SELECT col_not_null(     'purchasing', 'vendor', 'business_entity_id', 'Column purchasing.vendor.business_entity_id should be NOT NULL');
SELECT col_hasnt_default('purchasing', 'vendor', 'business_entity_id', 'Column purchasing.vendor.business_entity_id should not have a default');

SELECT has_column(       'purchasing', 'vendor', 'account_number', 'Column purchasing.vendor.account_number should exist');
SELECT col_type_is(      'purchasing', 'vendor', 'account_number', 'common.account_number', 'Column purchasing.vendor.account_number should be type common.account_number');
SELECT col_not_null(     'purchasing', 'vendor', 'account_number', 'Column purchasing.vendor.account_number should be NOT NULL');
SELECT col_hasnt_default('purchasing', 'vendor', 'account_number', 'Column purchasing.vendor.account_number should not have a default');

SELECT has_column(       'purchasing', 'vendor', 'name', 'Column purchasing.vendor.name should exist');
SELECT col_type_is(      'purchasing', 'vendor', 'name', 'common.name', 'Column purchasing.vendor.name should be type common.name');
SELECT col_not_null(     'purchasing', 'vendor', 'name', 'Column purchasing.vendor.name should be NOT NULL');
SELECT col_hasnt_default('purchasing', 'vendor', 'name', 'Column purchasing.vendor.name should not have a default');

SELECT has_column(       'purchasing', 'vendor', 'credit_rating', 'Column purchasing.vendor.credit_rating should exist');
SELECT col_type_is(      'purchasing', 'vendor', 'credit_rating', 'smallint', 'Column purchasing.vendor.credit_rating should be type smallint');
SELECT col_not_null(     'purchasing', 'vendor', 'credit_rating', 'Column purchasing.vendor.credit_rating should be NOT NULL');
SELECT col_hasnt_default('purchasing', 'vendor', 'credit_rating', 'Column purchasing.vendor.credit_rating should not have a default');
SELECT col_has_check(    'purchasing', 'vendor', 'credit_rating', 'Column purchasing.vendor.credit_rating should have a check constraint');

SELECT has_column(       'purchasing', 'vendor', 'preferred_vendor_status', 'Column purchasing.vendor.preferred_vendor_status should exist');
SELECT col_type_is(      'purchasing', 'vendor', 'preferred_vendor_status', 'common.flag', 'Column purchasing.vendor.preferred_vendor_status should be type common.flag');
SELECT col_not_null(     'purchasing', 'vendor', 'preferred_vendor_status', 'Column purchasing.vendor.preferred_vendor_status should be NOT NULL');
SELECT col_has_default(  'purchasing', 'vendor', 'preferred_vendor_status', 'Column purchasing.vendor.preferred_vendor_status should have a default');
SELECT col_default_is(   'purchasing', 'vendor', 'preferred_vendor_status', 'true', 'Column purchasing.vendor.preferred_vendor_status default is');

SELECT has_column(       'purchasing', 'vendor', 'active_flag', 'Column purchasing.vendor.active_flag should exist');
SELECT col_type_is(      'purchasing', 'vendor', 'active_flag', 'common.flag', 'Column purchasing.vendor.active_flag should be type common.flag');
SELECT col_not_null(     'purchasing', 'vendor', 'active_flag', 'Column purchasing.vendor.active_flag should be NOT NULL');
SELECT col_has_default(  'purchasing', 'vendor', 'active_flag', 'Column purchasing.vendor.active_flag should have a default');
SELECT col_default_is(   'purchasing', 'vendor', 'active_flag', 'true', 'Column purchasing.vendor.active_flag default is');

SELECT has_column(       'purchasing', 'vendor', 'purchasing_web_service_url', 'Column purchasing.vendor.purchasing_web_service_url should exist');
SELECT col_type_is(      'purchasing', 'vendor', 'purchasing_web_service_url', 'character varying(1024)', 'Column purchasing.vendor.purchasing_web_service_url should be type character varying(1024)');
SELECT col_is_null(      'purchasing', 'vendor', 'purchasing_web_service_url', 'Column purchasing.vendor.purchasing_web_service_url should allow NULL');
SELECT col_hasnt_default('purchasing', 'vendor', 'purchasing_web_service_url', 'Column purchasing.vendor.purchasing_web_service_url should not have a default');

SELECT has_column(       'purchasing', 'vendor', 'modified_date', 'Column purchasing.vendor.modified_date should exist');
SELECT col_type_is(      'purchasing', 'vendor', 'modified_date', 'timestamp without time zone', 'Column purchasing.vendor.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'purchasing', 'vendor', 'modified_date', 'Column purchasing.vendor.modified_date should be NOT NULL');
SELECT col_has_default(  'purchasing', 'vendor', 'modified_date', 'Column purchasing.vendor.modified_date should have a default');
SELECT col_default_is(   'purchasing', 'vendor', 'modified_date', 'timezone(''utc''::text, now())', 'Column purchasing.vendor.modified_date default is');

SELECT * FROM finish();
ROLLBACK;

