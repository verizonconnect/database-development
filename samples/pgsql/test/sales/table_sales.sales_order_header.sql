SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(125);

SELECT has_table(
    'sales', 'sales_order_header',
    'Should have table sales.sales_order_header'
);

SELECT has_pk(
    'sales', 'sales_order_header',
    'Table sales.sales_order_header should have a primary key'
);

SELECT has_check(
    'sales', 'sales_order_header',
    'Table sales.sales_order_header should have check contraint(s)'
);

SELECT col_is_pk('sales'::name, 'sales_order_header'::name, ARRAY[
    'sales_order_id'::name
],
'Primary key definition is not as expected');

SELECT columns_are('sales'::name, 'sales_order_header'::name, ARRAY[
    'sales_order_id'::name,
    'revision_number'::name,
    'order_date'::name,
    'due_date'::name,
    'ship_date'::name,
    'status'::name,
    'online_order_flag'::name,
    'sales_order_number'::name,
    'purchase_order_number'::name,
    'account_number'::name,
    'customer_id'::name,
    'sales_person_id'::name,
    'territory_id'::name,
    'bill_to_address_id'::name,
    'ship_to_address_id'::name,
    'ship_method_id'::name,
    'credit_card_id'::name,
    'credit_card_approval_code'::name,
    'currency_rate_id'::name,
    'sub_total'::name,
    'tax_amt'::name,
    'freight'::name,
    'total_due'::name,
    'comment'::name,
    'rowguid'::name,
    'modified_date'::name
]);

SELECT has_column(       'sales', 'sales_order_header', 'sales_order_id', 'Column sales.sales_order_header.sales_order_id should exist');
SELECT col_type_is(      'sales', 'sales_order_header', 'sales_order_id', 'integer', 'Column sales.sales_order_header.sales_order_id should be type integer');
SELECT col_not_null(     'sales', 'sales_order_header', 'sales_order_id', 'Column sales.sales_order_header.sales_order_id should be NOT NULL');
SELECT col_has_default(  'sales', 'sales_order_header', 'sales_order_id', 'Column sales.sales_order_header.sales_order_id should have a default');
SELECT col_default_is(   'sales', 'sales_order_header', 'sales_order_id', 'nextval(''sales.sales_order_header_sales_order_id_seq''::regclass)', 'Column sales.sales_order_header.sales_order_id default is');

SELECT has_column(       'sales', 'sales_order_header', 'revision_number', 'Column sales.sales_order_header.revision_number should exist');
SELECT col_type_is(      'sales', 'sales_order_header', 'revision_number', 'smallint', 'Column sales.sales_order_header.revision_number should be type smallint');
SELECT col_not_null(     'sales', 'sales_order_header', 'revision_number', 'Column sales.sales_order_header.revision_number should be NOT NULL');
SELECT col_has_default(  'sales', 'sales_order_header', 'revision_number', 'Column sales.sales_order_header.revision_number should have a default');
SELECT col_default_is(   'sales', 'sales_order_header', 'revision_number', '0', 'Column sales.sales_order_header.revision_number default is');

SELECT has_column(       'sales', 'sales_order_header', 'order_date', 'Column sales.sales_order_header.order_date should exist');
SELECT col_type_is(      'sales', 'sales_order_header', 'order_date', 'timestamp without time zone', 'Column sales.sales_order_header.order_date should be type timestamp without time zone');
SELECT col_not_null(     'sales', 'sales_order_header', 'order_date', 'Column sales.sales_order_header.order_date should be NOT NULL');
SELECT col_has_default(  'sales', 'sales_order_header', 'order_date', 'Column sales.sales_order_header.order_date should have a default');
SELECT col_default_is(   'sales', 'sales_order_header', 'order_date', 'timezone(''utc''::text, now())', 'Column sales.sales_order_header.order_date default is');

SELECT has_column(       'sales', 'sales_order_header', 'due_date', 'Column sales.sales_order_header.due_date should exist');
SELECT col_type_is(      'sales', 'sales_order_header', 'due_date', 'timestamp without time zone', 'Column sales.sales_order_header.due_date should be type timestamp without time zone');
SELECT col_not_null(     'sales', 'sales_order_header', 'due_date', 'Column sales.sales_order_header.due_date should be NOT NULL');
SELECT col_hasnt_default('sales', 'sales_order_header', 'due_date', 'Column sales.sales_order_header.due_date should not have a default');
SELECT col_has_check(    'sales', 'sales_order_header', ARRAY['due_date'::name,'order_date'::name], 'Columns sales.sales_order_header.[due_date,order_date] should have a check constraint');

SELECT has_column(       'sales', 'sales_order_header', 'ship_date', 'Column sales.sales_order_header.ship_date should exist');
SELECT col_type_is(      'sales', 'sales_order_header', 'ship_date', 'timestamp without time zone', 'Column sales.sales_order_header.ship_date should be type timestamp without time zone');
SELECT col_is_null(      'sales', 'sales_order_header', 'ship_date', 'Column sales.sales_order_header.ship_date should allow NULL');
SELECT col_hasnt_default('sales', 'sales_order_header', 'ship_date', 'Column sales.sales_order_header.ship_date should not have a default');
SELECT col_has_check(    'sales', 'sales_order_header', ARRAY['ship_date'::name,'order_date'::name], 'Columns sales.sales_order_header.[ship_date,order_date] should have a check constraint');

SELECT has_column(       'sales', 'sales_order_header', 'status', 'Column sales.sales_order_header.status should exist');
SELECT col_type_is(      'sales', 'sales_order_header', 'status', 'smallint', 'Column sales.sales_order_header.status should be type smallint');
SELECT col_not_null(     'sales', 'sales_order_header', 'status', 'Column sales.sales_order_header.status should be NOT NULL');
SELECT col_has_default(  'sales', 'sales_order_header', 'status', 'Column sales.sales_order_header.status should have a default');
SELECT col_default_is(   'sales', 'sales_order_header', 'status', '1', 'Column sales.sales_order_header.status default is');
SELECT col_has_check(    'sales', 'sales_order_header', 'status', 'Column sales.sales_order_header.status should have a check constraint');

SELECT has_column(       'sales', 'sales_order_header', 'online_order_flag', 'Column sales.sales_order_header.online_order_flag should exist');
SELECT col_type_is(      'sales', 'sales_order_header', 'online_order_flag', 'common.flag', 'Column sales.sales_order_header.online_order_flag should be type common.flag');
SELECT col_not_null(     'sales', 'sales_order_header', 'online_order_flag', 'Column sales.sales_order_header.online_order_flag should be NOT NULL');
SELECT col_has_default(  'sales', 'sales_order_header', 'online_order_flag', 'Column sales.sales_order_header.online_order_flag should have a default');
SELECT col_default_is(   'sales', 'sales_order_header', 'online_order_flag', 'true', 'Column sales.sales_order_header.online_order_flag default is');

SELECT has_column(       'sales', 'sales_order_header', 'sales_order_number', 'Column sales.sales_order_header.sales_order_number should exist');
SELECT col_type_is(      'sales', 'sales_order_header', 'sales_order_number', 'character varying(23)', 'Column sales.sales_order_header.sales_order_number should be type character varying(23)');
SELECT col_is_null(      'sales', 'sales_order_header', 'sales_order_number', 'Column sales.sales_order_header.sales_order_number should allow NULL');
SELECT col_hasnt_default('sales', 'sales_order_header', 'sales_order_number', 'Column sales.sales_order_header.sales_order_number should not have a default');

SELECT has_column(       'sales', 'sales_order_header', 'purchase_order_number', 'Column sales.sales_order_header.purchase_order_number should exist');
SELECT col_type_is(      'sales', 'sales_order_header', 'purchase_order_number', 'common.order_number', 'Column sales.sales_order_header.purchase_order_number should be type common.order_number');
SELECT col_is_null(      'sales', 'sales_order_header', 'purchase_order_number', 'Column sales.sales_order_header.purchase_order_number should allow NULL');
SELECT col_hasnt_default('sales', 'sales_order_header', 'purchase_order_number', 'Column sales.sales_order_header.purchase_order_number should not have a default');

SELECT has_column(       'sales', 'sales_order_header', 'account_number', 'Column sales.sales_order_header.account_number should exist');
SELECT col_type_is(      'sales', 'sales_order_header', 'account_number', 'common.account_number', 'Column sales.sales_order_header.account_number should be type common.account_number');
SELECT col_is_null(      'sales', 'sales_order_header', 'account_number', 'Column sales.sales_order_header.account_number should allow NULL');
SELECT col_hasnt_default('sales', 'sales_order_header', 'account_number', 'Column sales.sales_order_header.account_number should not have a default');

SELECT has_column(       'sales', 'sales_order_header', 'customer_id', 'Column sales.sales_order_header.customer_id should exist');
SELECT col_type_is(      'sales', 'sales_order_header', 'customer_id', 'integer', 'Column sales.sales_order_header.customer_id should be type integer');
SELECT col_not_null(     'sales', 'sales_order_header', 'customer_id', 'Column sales.sales_order_header.customer_id should be NOT NULL');
SELECT col_hasnt_default('sales', 'sales_order_header', 'customer_id', 'Column sales.sales_order_header.customer_id should not have a default');

SELECT has_column(       'sales', 'sales_order_header', 'sales_person_id', 'Column sales.sales_order_header.sales_person_id should exist');
SELECT col_type_is(      'sales', 'sales_order_header', 'sales_person_id', 'integer', 'Column sales.sales_order_header.sales_person_id should be type integer');
SELECT col_is_null(      'sales', 'sales_order_header', 'sales_person_id', 'Column sales.sales_order_header.sales_person_id should allow NULL');
SELECT col_hasnt_default('sales', 'sales_order_header', 'sales_person_id', 'Column sales.sales_order_header.sales_person_id should not have a default');

SELECT has_column(       'sales', 'sales_order_header', 'territory_id', 'Column sales.sales_order_header.territory_id should exist');
SELECT col_type_is(      'sales', 'sales_order_header', 'territory_id', 'integer', 'Column sales.sales_order_header.territory_id should be type integer');
SELECT col_is_null(      'sales', 'sales_order_header', 'territory_id', 'Column sales.sales_order_header.territory_id should allow NULL');
SELECT col_hasnt_default('sales', 'sales_order_header', 'territory_id', 'Column sales.sales_order_header.territory_id should not have a default');

SELECT has_column(       'sales', 'sales_order_header', 'bill_to_address_id', 'Column sales.sales_order_header.bill_to_address_id should exist');
SELECT col_type_is(      'sales', 'sales_order_header', 'bill_to_address_id', 'integer', 'Column sales.sales_order_header.bill_to_address_id should be type integer');
SELECT col_not_null(     'sales', 'sales_order_header', 'bill_to_address_id', 'Column sales.sales_order_header.bill_to_address_id should be NOT NULL');
SELECT col_hasnt_default('sales', 'sales_order_header', 'bill_to_address_id', 'Column sales.sales_order_header.bill_to_address_id should not have a default');

SELECT has_column(       'sales', 'sales_order_header', 'ship_to_address_id', 'Column sales.sales_order_header.ship_to_address_id should exist');
SELECT col_type_is(      'sales', 'sales_order_header', 'ship_to_address_id', 'integer', 'Column sales.sales_order_header.ship_to_address_id should be type integer');
SELECT col_not_null(     'sales', 'sales_order_header', 'ship_to_address_id', 'Column sales.sales_order_header.ship_to_address_id should be NOT NULL');
SELECT col_hasnt_default('sales', 'sales_order_header', 'ship_to_address_id', 'Column sales.sales_order_header.ship_to_address_id should not have a default');

SELECT has_column(       'sales', 'sales_order_header', 'ship_method_id', 'Column sales.sales_order_header.ship_method_id should exist');
SELECT col_type_is(      'sales', 'sales_order_header', 'ship_method_id', 'integer', 'Column sales.sales_order_header.ship_method_id should be type integer');
SELECT col_not_null(     'sales', 'sales_order_header', 'ship_method_id', 'Column sales.sales_order_header.ship_method_id should be NOT NULL');
SELECT col_hasnt_default('sales', 'sales_order_header', 'ship_method_id', 'Column sales.sales_order_header.ship_method_id should not have a default');

SELECT has_column(       'sales', 'sales_order_header', 'credit_card_id', 'Column sales.sales_order_header.credit_card_id should exist');
SELECT col_type_is(      'sales', 'sales_order_header', 'credit_card_id', 'integer', 'Column sales.sales_order_header.credit_card_id should be type integer');
SELECT col_is_null(      'sales', 'sales_order_header', 'credit_card_id', 'Column sales.sales_order_header.credit_card_id should allow NULL');
SELECT col_hasnt_default('sales', 'sales_order_header', 'credit_card_id', 'Column sales.sales_order_header.credit_card_id should not have a default');

SELECT has_column(       'sales', 'sales_order_header', 'credit_card_approval_code', 'Column sales.sales_order_header.credit_card_approval_code should exist');
SELECT col_type_is(      'sales', 'sales_order_header', 'credit_card_approval_code', 'character varying(15)', 'Column sales.sales_order_header.credit_card_approval_code should be type character varying(15)');
SELECT col_is_null(      'sales', 'sales_order_header', 'credit_card_approval_code', 'Column sales.sales_order_header.credit_card_approval_code should allow NULL');
SELECT col_hasnt_default('sales', 'sales_order_header', 'credit_card_approval_code', 'Column sales.sales_order_header.credit_card_approval_code should not have a default');

SELECT has_column(       'sales', 'sales_order_header', 'currency_rate_id', 'Column sales.sales_order_header.currency_rate_id should exist');
SELECT col_type_is(      'sales', 'sales_order_header', 'currency_rate_id', 'integer', 'Column sales.sales_order_header.currency_rate_id should be type integer');
SELECT col_is_null(      'sales', 'sales_order_header', 'currency_rate_id', 'Column sales.sales_order_header.currency_rate_id should allow NULL');
SELECT col_hasnt_default('sales', 'sales_order_header', 'currency_rate_id', 'Column sales.sales_order_header.currency_rate_id should not have a default');

SELECT has_column(       'sales', 'sales_order_header', 'sub_total', 'Column sales.sales_order_header.sub_total should exist');
SELECT col_type_is(      'sales', 'sales_order_header', 'sub_total', 'numeric', 'Column sales.sales_order_header.sub_total should be type numeric');
SELECT col_not_null(     'sales', 'sales_order_header', 'sub_total', 'Column sales.sales_order_header.sub_total should be NOT NULL');
SELECT col_has_default(  'sales', 'sales_order_header', 'sub_total', 'Column sales.sales_order_header.sub_total should have a default');
SELECT col_default_is(   'sales', 'sales_order_header', 'sub_total', '0.00', 'Column sales.sales_order_header.sub_total default is');
SELECT col_has_check(    'sales', 'sales_order_header', 'sub_total', 'Column sales.sales_order_header.sub_total should have a check constraint');

SELECT has_column(       'sales', 'sales_order_header', 'tax_amt', 'Column sales.sales_order_header.tax_amt should exist');
SELECT col_type_is(      'sales', 'sales_order_header', 'tax_amt', 'numeric', 'Column sales.sales_order_header.tax_amt should be type numeric');
SELECT col_not_null(     'sales', 'sales_order_header', 'tax_amt', 'Column sales.sales_order_header.tax_amt should be NOT NULL');
SELECT col_has_default(  'sales', 'sales_order_header', 'tax_amt', 'Column sales.sales_order_header.tax_amt should have a default');
SELECT col_default_is(   'sales', 'sales_order_header', 'tax_amt', '0.00', 'Column sales.sales_order_header.tax_amt default is');
SELECT col_has_check(    'sales', 'sales_order_header', 'tax_amt', 'Column sales.sales_order_header.tax_amt should have a check constraint');

SELECT has_column(       'sales', 'sales_order_header', 'freight', 'Column sales.sales_order_header.freight should exist');
SELECT col_type_is(      'sales', 'sales_order_header', 'freight', 'numeric', 'Column sales.sales_order_header.freight should be type numeric');
SELECT col_not_null(     'sales', 'sales_order_header', 'freight', 'Column sales.sales_order_header.freight should be NOT NULL');
SELECT col_has_default(  'sales', 'sales_order_header', 'freight', 'Column sales.sales_order_header.freight should have a default');
SELECT col_default_is(   'sales', 'sales_order_header', 'freight', '0.00', 'Column sales.sales_order_header.freight default is');
SELECT col_has_check(    'sales', 'sales_order_header', 'freight', 'Column sales.sales_order_header.freight should have a check constraint');

SELECT has_column(       'sales', 'sales_order_header', 'total_due', 'Column sales.sales_order_header.total_due should exist');
SELECT col_type_is(      'sales', 'sales_order_header', 'total_due', 'numeric', 'Column sales.sales_order_header.total_due should be type numeric');
SELECT col_is_null(      'sales', 'sales_order_header', 'total_due', 'Column sales.sales_order_header.total_due should allow NULL');
SELECT col_hasnt_default('sales', 'sales_order_header', 'total_due', 'Column sales.sales_order_header.total_due should not have a default');

SELECT has_column(       'sales', 'sales_order_header', 'comment', 'Column sales.sales_order_header.comment should exist');
SELECT col_type_is(      'sales', 'sales_order_header', 'comment', 'character varying(128)', 'Column sales.sales_order_header.comment should be type character varying(128)');
SELECT col_is_null(      'sales', 'sales_order_header', 'comment', 'Column sales.sales_order_header.comment should allow NULL');
SELECT col_hasnt_default('sales', 'sales_order_header', 'comment', 'Column sales.sales_order_header.comment should not have a default');

SELECT has_column(       'sales', 'sales_order_header', 'rowguid', 'Column sales.sales_order_header.rowguid should exist');
SELECT col_type_is(      'sales', 'sales_order_header', 'rowguid', 'uuid', 'Column sales.sales_order_header.rowguid should be type uuid');
SELECT col_not_null(     'sales', 'sales_order_header', 'rowguid', 'Column sales.sales_order_header.rowguid should be NOT NULL');
SELECT col_has_default(  'sales', 'sales_order_header', 'rowguid', 'Column sales.sales_order_header.rowguid should have a default');
SELECT col_default_is(   'sales', 'sales_order_header', 'rowguid', 'common.uuid_generate_v1()', 'Column sales.sales_order_header.rowguid default is');

SELECT has_column(       'sales', 'sales_order_header', 'modified_date', 'Column sales.sales_order_header.modified_date should exist');
SELECT col_type_is(      'sales', 'sales_order_header', 'modified_date', 'timestamp without time zone', 'Column sales.sales_order_header.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'sales', 'sales_order_header', 'modified_date', 'Column sales.sales_order_header.modified_date should be NOT NULL');
SELECT col_has_default(  'sales', 'sales_order_header', 'modified_date', 'Column sales.sales_order_header.modified_date should have a default');
SELECT col_default_is(   'sales', 'sales_order_header', 'modified_date', 'timezone(''utc''::text, now())', 'Column sales.sales_order_header.modified_date default is');

SELECT * FROM finish();
ROLLBACK;

