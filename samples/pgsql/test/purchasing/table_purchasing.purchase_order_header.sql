SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(70);

SELECT has_table(
    'purchasing', 'purchase_order_header',
    'Should have table purchasing.purchase_order_header'
);

SELECT has_pk(
    'purchasing', 'purchase_order_header',
    'Table purchasing.purchase_order_header should have a primary key'
);

SELECT has_check(
    'purchasing', 'purchase_order_header',
    'Table purchasing.purchase_order_header should have check contraint(s)'
);

SELECT col_is_pk('purchasing'::name, 'purchase_order_header'::name, ARRAY[
    'purchase_order_id'::name
],
'Primary key definition is not as expected');

SELECT columns_are('purchasing'::name, 'purchase_order_header'::name, ARRAY[
    'purchase_order_id'::name,
    'revision_number'::name,
    'status'::name,
    'employee_id'::name,
    'vendor_id'::name,
    'ship_method_id'::name,
    'order_date'::name,
    'ship_date'::name,
    'sub_total'::name,
    'tax_amt'::name,
    'freight'::name,
    'total_due'::name,
    'modified_date'::name
]);

SELECT has_column(       'purchasing', 'purchase_order_header', 'purchase_order_id', 'Column purchasing.purchase_order_header.purchase_order_id should exist');
SELECT col_type_is(      'purchasing', 'purchase_order_header', 'purchase_order_id', 'integer', 'Column purchasing.purchase_order_header.purchase_order_id should be type integer');
SELECT col_not_null(     'purchasing', 'purchase_order_header', 'purchase_order_id', 'Column purchasing.purchase_order_header.purchase_order_id should be NOT NULL');
SELECT col_has_default(  'purchasing', 'purchase_order_header', 'purchase_order_id', 'Column purchasing.purchase_order_header.purchase_order_id should have a default');
SELECT col_default_is(   'purchasing', 'purchase_order_header', 'purchase_order_id', 'nextval(''purchasing.purchase_order_header_purchase_order_id_seq''::regclass)', 'Column purchasing.purchase_order_header.purchase_order_id default is');

SELECT has_column(       'purchasing', 'purchase_order_header', 'revision_number', 'Column purchasing.purchase_order_header.revision_number should exist');
SELECT col_type_is(      'purchasing', 'purchase_order_header', 'revision_number', 'smallint', 'Column purchasing.purchase_order_header.revision_number should be type smallint');
SELECT col_not_null(     'purchasing', 'purchase_order_header', 'revision_number', 'Column purchasing.purchase_order_header.revision_number should be NOT NULL');
SELECT col_has_default(  'purchasing', 'purchase_order_header', 'revision_number', 'Column purchasing.purchase_order_header.revision_number should have a default');
SELECT col_default_is(   'purchasing', 'purchase_order_header', 'revision_number', '0', 'Column purchasing.purchase_order_header.revision_number default is');

SELECT has_column(       'purchasing', 'purchase_order_header', 'status', 'Column purchasing.purchase_order_header.status should exist');
SELECT col_type_is(      'purchasing', 'purchase_order_header', 'status', 'smallint', 'Column purchasing.purchase_order_header.status should be type smallint');
SELECT col_not_null(     'purchasing', 'purchase_order_header', 'status', 'Column purchasing.purchase_order_header.status should be NOT NULL');
SELECT col_has_default(  'purchasing', 'purchase_order_header', 'status', 'Column purchasing.purchase_order_header.status should have a default');
SELECT col_default_is(   'purchasing', 'purchase_order_header', 'status', '1', 'Column purchasing.purchase_order_header.status default is');
SELECT col_has_check(    'purchasing', 'purchase_order_header', 'status', 'Column purchasing.purchase_order_header.status should have a check constraint');

SELECT has_column(       'purchasing', 'purchase_order_header', 'employee_id', 'Column purchasing.purchase_order_header.employee_id should exist');
SELECT col_type_is(      'purchasing', 'purchase_order_header', 'employee_id', 'integer', 'Column purchasing.purchase_order_header.employee_id should be type integer');
SELECT col_not_null(     'purchasing', 'purchase_order_header', 'employee_id', 'Column purchasing.purchase_order_header.employee_id should be NOT NULL');
SELECT col_hasnt_default('purchasing', 'purchase_order_header', 'employee_id', 'Column purchasing.purchase_order_header.employee_id should not have a default');

SELECT has_column(       'purchasing', 'purchase_order_header', 'vendor_id', 'Column purchasing.purchase_order_header.vendor_id should exist');
SELECT col_type_is(      'purchasing', 'purchase_order_header', 'vendor_id', 'integer', 'Column purchasing.purchase_order_header.vendor_id should be type integer');
SELECT col_not_null(     'purchasing', 'purchase_order_header', 'vendor_id', 'Column purchasing.purchase_order_header.vendor_id should be NOT NULL');
SELECT col_hasnt_default('purchasing', 'purchase_order_header', 'vendor_id', 'Column purchasing.purchase_order_header.vendor_id should not have a default');

SELECT has_column(       'purchasing', 'purchase_order_header', 'ship_method_id', 'Column purchasing.purchase_order_header.ship_method_id should exist');
SELECT col_type_is(      'purchasing', 'purchase_order_header', 'ship_method_id', 'integer', 'Column purchasing.purchase_order_header.ship_method_id should be type integer');
SELECT col_not_null(     'purchasing', 'purchase_order_header', 'ship_method_id', 'Column purchasing.purchase_order_header.ship_method_id should be NOT NULL');
SELECT col_hasnt_default('purchasing', 'purchase_order_header', 'ship_method_id', 'Column purchasing.purchase_order_header.ship_method_id should not have a default');

SELECT has_column(       'purchasing', 'purchase_order_header', 'order_date', 'Column purchasing.purchase_order_header.order_date should exist');
SELECT col_type_is(      'purchasing', 'purchase_order_header', 'order_date', 'timestamp without time zone', 'Column purchasing.purchase_order_header.order_date should be type timestamp without time zone');
SELECT col_not_null(     'purchasing', 'purchase_order_header', 'order_date', 'Column purchasing.purchase_order_header.order_date should be NOT NULL');
SELECT col_has_default(  'purchasing', 'purchase_order_header', 'order_date', 'Column purchasing.purchase_order_header.order_date should have a default');
SELECT col_default_is(   'purchasing', 'purchase_order_header', 'order_date', 'timezone(''utc''::text, now())', 'Column purchasing.purchase_order_header.order_date default is');

SELECT has_column(       'purchasing', 'purchase_order_header', 'ship_date', 'Column purchasing.purchase_order_header.ship_date should exist');
SELECT col_type_is(      'purchasing', 'purchase_order_header', 'ship_date', 'timestamp without time zone', 'Column purchasing.purchase_order_header.ship_date should be type timestamp without time zone');
SELECT col_is_null(      'purchasing', 'purchase_order_header', 'ship_date', 'Column purchasing.purchase_order_header.ship_date should allow NULL');
SELECT col_hasnt_default('purchasing', 'purchase_order_header', 'ship_date', 'Column purchasing.purchase_order_header.ship_date should not have a default');
SELECT col_has_check(    'purchasing', 'purchase_order_header', ARRAY['ship_date'::name,'order_date'::name], 'Columns purchasing.purchase_order_header.[ship_date,order_date] should have a check constraint');

SELECT has_column(       'purchasing', 'purchase_order_header', 'sub_total', 'Column purchasing.purchase_order_header.sub_total should exist');
SELECT col_type_is(      'purchasing', 'purchase_order_header', 'sub_total', 'numeric', 'Column purchasing.purchase_order_header.sub_total should be type numeric');
SELECT col_not_null(     'purchasing', 'purchase_order_header', 'sub_total', 'Column purchasing.purchase_order_header.sub_total should be NOT NULL');
SELECT col_has_default(  'purchasing', 'purchase_order_header', 'sub_total', 'Column purchasing.purchase_order_header.sub_total should have a default');
SELECT col_default_is(   'purchasing', 'purchase_order_header', 'sub_total', '0.00', 'Column purchasing.purchase_order_header.sub_total default is');
SELECT col_has_check(    'purchasing', 'purchase_order_header', 'sub_total', 'Column purchasing.purchase_order_header.sub_total should have a check constraint');

SELECT has_column(       'purchasing', 'purchase_order_header', 'tax_amt', 'Column purchasing.purchase_order_header.tax_amt should exist');
SELECT col_type_is(      'purchasing', 'purchase_order_header', 'tax_amt', 'numeric', 'Column purchasing.purchase_order_header.tax_amt should be type numeric');
SELECT col_not_null(     'purchasing', 'purchase_order_header', 'tax_amt', 'Column purchasing.purchase_order_header.tax_amt should be NOT NULL');
SELECT col_has_default(  'purchasing', 'purchase_order_header', 'tax_amt', 'Column purchasing.purchase_order_header.tax_amt should have a default');
SELECT col_default_is(   'purchasing', 'purchase_order_header', 'tax_amt', '0.00', 'Column purchasing.purchase_order_header.tax_amt default is');
SELECT col_has_check(    'purchasing', 'purchase_order_header', 'tax_amt', 'Column purchasing.purchase_order_header.tax_amt should have a check constraint');

SELECT has_column(       'purchasing', 'purchase_order_header', 'freight', 'Column purchasing.purchase_order_header.freight should exist');
SELECT col_type_is(      'purchasing', 'purchase_order_header', 'freight', 'numeric', 'Column purchasing.purchase_order_header.freight should be type numeric');
SELECT col_not_null(     'purchasing', 'purchase_order_header', 'freight', 'Column purchasing.purchase_order_header.freight should be NOT NULL');
SELECT col_has_default(  'purchasing', 'purchase_order_header', 'freight', 'Column purchasing.purchase_order_header.freight should have a default');
SELECT col_default_is(   'purchasing', 'purchase_order_header', 'freight', '0.00', 'Column purchasing.purchase_order_header.freight default is');
SELECT col_has_check(    'purchasing', 'purchase_order_header', 'freight', 'Column purchasing.purchase_order_header.freight should have a check constraint');

SELECT has_column(       'purchasing', 'purchase_order_header', 'total_due', 'Column purchasing.purchase_order_header.total_due should exist');
SELECT col_type_is(      'purchasing', 'purchase_order_header', 'total_due', 'numeric', 'Column purchasing.purchase_order_header.total_due should be type numeric');
SELECT col_is_null(      'purchasing', 'purchase_order_header', 'total_due', 'Column purchasing.purchase_order_header.total_due should allow NULL');
SELECT col_hasnt_default('purchasing', 'purchase_order_header', 'total_due', 'Column purchasing.purchase_order_header.total_due should not have a default');

SELECT has_column(       'purchasing', 'purchase_order_header', 'modified_date', 'Column purchasing.purchase_order_header.modified_date should exist');
SELECT col_type_is(      'purchasing', 'purchase_order_header', 'modified_date', 'timestamp without time zone', 'Column purchasing.purchase_order_header.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'purchasing', 'purchase_order_header', 'modified_date', 'Column purchasing.purchase_order_header.modified_date should be NOT NULL');
SELECT col_has_default(  'purchasing', 'purchase_order_header', 'modified_date', 'Column purchasing.purchase_order_header.modified_date should have a default');
SELECT col_default_is(   'purchasing', 'purchase_order_header', 'modified_date', 'timezone(''utc''::text, now())', 'Column purchasing.purchase_order_header.modified_date default is');

SELECT * FROM finish();
ROLLBACK;

