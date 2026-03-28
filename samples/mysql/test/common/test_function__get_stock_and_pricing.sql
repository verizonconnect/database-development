USE tap;
BEGIN;
SELECT tap.plan(5);

-- assemble
INSERT INTO production.location (location_id, name) VALUES (6, 'Miscellaneous Storage');

INSERT INTO production.product (
    product_id, name, product_number, safety_stock_level
   ,reorder_point, standard_cost, list_price, days_to_manufacture
   ,sell_start_date
) VALUES (9001, 'Test Widget', 'TW-9001', 10, 5, 1.00, 2.00, 1, '2024-01-01');

INSERT INTO production.product_inventory (product_id, location_id, shelf, bin, quantity)
VALUES (9001, 6, 'A', 1, 25);

INSERT INTO production.product_list_price_history (product_id, start_date, end_date, list_price)
VALUES (9001, '2024-01-01', '2024-12-31', 100.00);

INSERT INTO production.product_cost_history (product_id, start_date, end_date, standard_cost)
VALUES (9001, '2024-01-01', '2024-12-31', 45.50);

-- act: call functions into variables
SET @stock_exists = common.get_stock(9001);
SET @stock_missing = common.get_stock(-1);
SET @dealer_price = common.get_product_dealer_price(9001, '2024-06-15');
SET @list_cost = common.get_product_list_cost(9001, '2024-06-15');
SET @std_cost = common.get_product_standard_cost(9001, '2024-06-15');

-- assert
SELECT tap.ok(@stock_exists = 25, 'get_stock should return 25 for product with inventory');
SELECT tap.ok(@stock_missing = 0, 'get_stock should return 0 for non-existent product');
SELECT tap.ok(@dealer_price = 60.0000, 'get_product_dealer_price should return 60% of list price');
SELECT tap.ok(@list_cost = 100.00, 'get_product_list_cost should return list price from history');
SELECT tap.ok(@std_cost = 45.50, 'get_product_standard_cost should return cost from history');

CALL tap.finish();
ROLLBACK;
