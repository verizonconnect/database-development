SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(31);

SELECT tables_are('sales', ARRAY[
    'country_region_currency',
    'credit_card',
    'currency',
    'currency_rate',
    'customer',
    'person_credit_card',
    'sales_order_detail',
    'sales_order_header',
    'sales_order_header_sales_reason',
    'sales_person',
    'sales_person_quota_history',
    'sales_reason',
    'sales_tax_rate',
    'sales_territory',
    'sales_territory_history',
    'shopping_cart_item',
    'special_offer',
    'special_offer_product',
    'store'
]);

SELECT table_owner_is('sales','country_region_currency','postgres','sales.country_region_currency owner is postgres');
SELECT table_owner_is('sales','credit_card','postgres','sales.credit_card owner is postgres');
SELECT table_owner_is('sales','currency','postgres','sales.currency owner is postgres');
SELECT table_owner_is('sales','currency_rate','postgres','sales.currency_rate owner is postgres');
SELECT table_owner_is('sales','customer','postgres','sales.customer owner is postgres');
SELECT table_owner_is('sales','person_credit_card','postgres','sales.person_credit_card owner is postgres');
SELECT table_owner_is('sales','sales_order_detail','postgres','sales.sales_order_detail owner is postgres');
SELECT table_owner_is('sales','sales_order_header','postgres','sales.sales_order_header owner is postgres');
SELECT table_owner_is('sales','sales_order_header_sales_reason','postgres','sales.sales_order_header_sales_reason owner is postgres');
SELECT table_owner_is('sales','sales_person','postgres','sales.sales_person owner is postgres');
SELECT table_owner_is('sales','sales_person_quota_history','postgres','sales.sales_person_quota_history owner is postgres');
SELECT table_owner_is('sales','sales_reason','postgres','sales.sales_reason owner is postgres');
SELECT table_owner_is('sales','sales_tax_rate','postgres','sales.sales_tax_rate owner is postgres');
SELECT table_owner_is('sales','sales_territory','postgres','sales.sales_territory owner is postgres');
SELECT table_owner_is('sales','sales_territory_history','postgres','sales.sales_territory_history owner is postgres');
SELECT table_owner_is('sales','shopping_cart_item','postgres','sales.shopping_cart_item owner is postgres');
SELECT table_owner_is('sales','special_offer','postgres','sales.special_offer owner is postgres');
SELECT table_owner_is('sales','special_offer_product','postgres','sales.special_offer_product owner is postgres');
SELECT table_owner_is('sales','store','postgres','sales.store owner is postgres');
SELECT sequences_are('sales', ARRAY[
    'credit_card_credit_card_id_seq',
    'currency_rate_currency_rate_id_seq',
    'customer_customer_id_seq',
    'sales_order_detail_sales_order_detail_id_seq',
    'sales_order_header_sales_order_id_seq',
    'sales_reason_sales_reason_id_seq',
    'sales_tax_rate_sales_tax_rate_id_seq',
    'sales_territory_territory_id_seq',
    'shopping_cart_item_shopping_cart_item_id_seq',
    'special_offer_special_offer_id_seq'
]);

SELECT sequence_owner_is('sales','credit_card_credit_card_id_seq','postgres','sales.credit_card_credit_card_id_seq owner is postgres');
SELECT sequence_owner_is('sales','currency_rate_currency_rate_id_seq','postgres','sales.currency_rate_currency_rate_id_seq owner is postgres');
SELECT sequence_owner_is('sales','customer_customer_id_seq','postgres','sales.customer_customer_id_seq owner is postgres');
SELECT sequence_owner_is('sales','sales_order_detail_sales_order_detail_id_seq','postgres','sales.sales_order_detail_sales_order_detail_id_seq owner is postgres');
SELECT sequence_owner_is('sales','sales_order_header_sales_order_id_seq','postgres','sales.sales_order_header_sales_order_id_seq owner is postgres');
SELECT sequence_owner_is('sales','sales_reason_sales_reason_id_seq','postgres','sales.sales_reason_sales_reason_id_seq owner is postgres');
SELECT sequence_owner_is('sales','sales_tax_rate_sales_tax_rate_id_seq','postgres','sales.sales_tax_rate_sales_tax_rate_id_seq owner is postgres');
SELECT sequence_owner_is('sales','sales_territory_territory_id_seq','postgres','sales.sales_territory_territory_id_seq owner is postgres');
SELECT sequence_owner_is('sales','shopping_cart_item_shopping_cart_item_id_seq','postgres','sales.shopping_cart_item_shopping_cart_item_id_seq owner is postgres');
SELECT sequence_owner_is('sales','special_offer_special_offer_id_seq','postgres','sales.special_offer_special_offer_id_seq owner is postgres');

SELECT * FROM finish();
ROLLBACK;
