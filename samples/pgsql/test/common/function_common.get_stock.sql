SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
    SELECT plan(2);

    -- assemble phase
    INSERT INTO production.location (location_id, name)
    VALUES (6, 'Miscellaneous Storage');

    INSERT INTO production.product (
        product_id, name, product_number, safety_stock_level
       ,reorder_point, standard_cost, list_price, days_to_manufacture
       ,sell_start_date
    ) VALUES (
        9999, 'Test Widget', 'TW-9999', 10
       ,5, 1.00, 2.00, 1
       ,'2024-01-01'
    );

    INSERT INTO production.product_inventory (
        product_id, location_id, shelf, bin, quantity
    ) VALUES (
        9999, 6, 'A', 1, 25
    );

    -- act / assert phase

    -- Test 1: product with inventory in location 6 returns the quantity
    SELECT is(
        common.get_stock(9999)
       ,25
       ,'get_stock should return 25 for product with inventory in location 6'
    );

    -- Test 2: product with no inventory returns 0 (IF NULL branch)
    SELECT is(
        common.get_stock(-1)
       ,0
       ,'get_stock should return 0 for product with no inventory'
    );

    SELECT * FROM finish();
ROLLBACK;
