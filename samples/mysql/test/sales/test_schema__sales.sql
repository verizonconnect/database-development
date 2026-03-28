USE tap;
BEGIN;
SELECT tap.plan(57);

-- sales.country_region_currency
SELECT tap.has_table('sales','country_region_currency','');
SELECT tap.table_engine_is('sales','country_region_currency','InnoDB','');
SELECT tap.columns_are('sales','country_region_currency','`country_region_code`,`currency_code`,`modified_date`','');

-- sales.credit_card
SELECT tap.has_table('sales','credit_card','');
SELECT tap.table_engine_is('sales','credit_card','InnoDB','');
SELECT tap.columns_are('sales','credit_card','`credit_card_id`,`card_type`,`card_number`,`exp_month`,`exp_year`,`modified_date`','');

-- sales.currency
SELECT tap.has_table('sales','currency','');
SELECT tap.table_engine_is('sales','currency','InnoDB','');
SELECT tap.columns_are('sales','currency','`currency_code`,`name`,`modified_date`','');

-- sales.currency_rate
SELECT tap.has_table('sales','currency_rate','');
SELECT tap.table_engine_is('sales','currency_rate','InnoDB','');
SELECT tap.columns_are('sales','currency_rate','`currency_rate_id`,`currency_rate_date`,`from_currency_code`,`to_currency_code`,`average_rate`,`end_of_day_rate`,`modified_date`','');

-- sales.customer
SELECT tap.has_table('sales','customer','');
SELECT tap.table_engine_is('sales','customer','InnoDB','');
SELECT tap.columns_are('sales','customer','`customer_id`,`person_id`,`store_id`,`territory_id`,`account_number`,`rowguid`,`modified_date`','');

-- sales.person_credit_card
SELECT tap.has_table('sales','person_credit_card','');
SELECT tap.table_engine_is('sales','person_credit_card','InnoDB','');
SELECT tap.columns_are('sales','person_credit_card','`business_entity_id`,`credit_card_id`,`modified_date`','');

-- sales.sales_order_detail
SELECT tap.has_table('sales','sales_order_detail','');
SELECT tap.table_engine_is('sales','sales_order_detail','InnoDB','');
SELECT tap.columns_are('sales','sales_order_detail','`sales_order_id`,`sales_order_detail_id`,`carrier_tracking_number`,`order_qty`,`product_id`,`special_offer_id`,`unit_price`,`unit_price_discount`,`line_total`,`rowguid`,`modified_date`','');

-- sales.sales_order_header
SELECT tap.has_table('sales','sales_order_header','');
SELECT tap.table_engine_is('sales','sales_order_header','InnoDB','');
SELECT tap.columns_are('sales','sales_order_header','`sales_order_id`,`revision_number`,`order_date`,`due_date`,`ship_date`,`status`,`online_order_flag`,`sales_order_number`,`purchase_order_number`,`account_number`,`customer_id`,`sales_person_id`,`territory_id`,`bill_to_address_id`,`ship_to_address_id`,`ship_method_id`,`credit_card_id`,`credit_card_approval_code`,`currency_rate_id`,`sub_total`,`tax_amt`,`freight`,`total_due`,`comment`,`rowguid`,`modified_date`','');

-- sales.sales_order_header_sales_reason
SELECT tap.has_table('sales','sales_order_header_sales_reason','');
SELECT tap.table_engine_is('sales','sales_order_header_sales_reason','InnoDB','');
SELECT tap.columns_are('sales','sales_order_header_sales_reason','`sales_order_id`,`sales_reason_id`,`modified_date`','');

-- sales.sales_person
SELECT tap.has_table('sales','sales_person','');
SELECT tap.table_engine_is('sales','sales_person','InnoDB','');
SELECT tap.columns_are('sales','sales_person','`business_entity_id`,`territory_id`,`sales_quota`,`bonus`,`commission_pct`,`sales_ytd`,`sales_last_year`,`rowguid`,`modified_date`','');

-- sales.sales_person_quota_history
SELECT tap.has_table('sales','sales_person_quota_history','');
SELECT tap.table_engine_is('sales','sales_person_quota_history','InnoDB','');
SELECT tap.columns_are('sales','sales_person_quota_history','`business_entity_id`,`quota_date`,`sales_quota`,`rowguid`,`modified_date`','');

-- sales.sales_reason
SELECT tap.has_table('sales','sales_reason','');
SELECT tap.table_engine_is('sales','sales_reason','InnoDB','');
SELECT tap.columns_are('sales','sales_reason','`sales_reason_id`,`name`,`reason_type`,`modified_date`','');

-- sales.sales_tax_rate
SELECT tap.has_table('sales','sales_tax_rate','');
SELECT tap.table_engine_is('sales','sales_tax_rate','InnoDB','');
SELECT tap.columns_are('sales','sales_tax_rate','`sales_tax_rate_id`,`state_province_id`,`tax_type`,`tax_rate`,`name`,`rowguid`,`modified_date`','');

-- sales.sales_territory
SELECT tap.has_table('sales','sales_territory','');
SELECT tap.table_engine_is('sales','sales_territory','InnoDB','');
SELECT tap.columns_are('sales','sales_territory','`territory_id`,`name`,`country_region_code`,`group`,`sales_ytd`,`sales_last_year`,`cost_ytd`,`cost_last_year`,`rowguid`,`modified_date`','');

-- sales.sales_territory_history
SELECT tap.has_table('sales','sales_territory_history','');
SELECT tap.table_engine_is('sales','sales_territory_history','InnoDB','');
SELECT tap.columns_are('sales','sales_territory_history','`business_entity_id`,`territory_id`,`start_date`,`end_date`,`rowguid`,`modified_date`','');

-- sales.shopping_cart_item
SELECT tap.has_table('sales','shopping_cart_item','');
SELECT tap.table_engine_is('sales','shopping_cart_item','InnoDB','');
SELECT tap.columns_are('sales','shopping_cart_item','`shopping_cart_item_id`,`shopping_cart_id`,`quantity`,`product_id`,`date_created`,`modified_date`','');

-- sales.special_offer
SELECT tap.has_table('sales','special_offer','');
SELECT tap.table_engine_is('sales','special_offer','InnoDB','');
SELECT tap.columns_are('sales','special_offer','`special_offer_id`,`description`,`discount_pct`,`type`,`category`,`start_date`,`end_date`,`min_qty`,`max_qty`,`rowguid`,`modified_date`','');

-- sales.special_offer_product
SELECT tap.has_table('sales','special_offer_product','');
SELECT tap.table_engine_is('sales','special_offer_product','InnoDB','');
SELECT tap.columns_are('sales','special_offer_product','`special_offer_id`,`product_id`,`rowguid`,`modified_date`','');

-- sales.store
SELECT tap.has_table('sales','store','');
SELECT tap.table_engine_is('sales','store','InnoDB','');
SELECT tap.columns_are('sales','store','`business_entity_id`,`name`,`sales_person_id`,`demographics`,`rowguid`,`modified_date`','');

CALL tap.finish();
ROLLBACK;
