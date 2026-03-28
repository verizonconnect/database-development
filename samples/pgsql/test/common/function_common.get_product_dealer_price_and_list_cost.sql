SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
    SELECT plan(3);

    -- assemble phase
    INSERT INTO production.product (
        product_id, name, product_number, safety_stock_level
       ,reorder_point, standard_cost, list_price, days_to_manufacture
       ,sell_start_date
    ) VALUES (
        8001, 'Price Test Widget', 'PT-8001', 10
       ,5, 10.00, 20.00, 1, '2024-01-01'
    );

    INSERT INTO production.product_list_price_history (
        product_id, start_date, end_date, list_price
    ) VALUES (
        8001, '2024-01-01', '2024-12-31', 25.00
    );

    -- act / assert phase

    -- Test 1: dealer price = list_price * 0.60
    SELECT is(
        common.get_product_dealer_price(8001, '2024-06-15'::TIMESTAMP)
       ,15.0000::NUMERIC
       ,'Dealer price should be 60% of list price (25 * 0.60 = 15)'
    );

    -- Test 2: list cost
    SELECT is(
        common.get_product_list_cost(8001, '2024-06-15'::TIMESTAMP)
       ,25.00::NUMERIC
       ,'List cost should return the list price from history'
    );

    -- Test 3: date outside range returns NULL
    SELECT is(
        common.get_product_list_cost(8001, '2025-06-15'::TIMESTAMP)
       ,NULL::NUMERIC
       ,'List cost should return NULL for date outside range'
    );

    SELECT * FROM finish();
ROLLBACK;
