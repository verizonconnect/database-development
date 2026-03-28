SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
    SELECT plan(2);

    -- assemble phase
    INSERT INTO production.product (
        product_id, name, product_number, safety_stock_level
       ,reorder_point, standard_cost, list_price, days_to_manufacture
       ,sell_start_date
    ) VALUES (
        8002, 'Cost Test Widget', 'CT-8002', 10
       ,5, 10.00, 20.00, 1, '2024-01-01'
    );

    INSERT INTO production.product_cost_history (
        product_id, start_date, end_date, standard_cost
    ) VALUES (
        8002, '2024-01-01', '2024-12-31', 12.50
    );

    -- act / assert phase

    SELECT is(
        common.get_product_standard_cost(8002, '2024-06-15'::TIMESTAMP)
       ,12.50::NUMERIC
       ,'Standard cost should return cost from history'
    );

    SELECT is(
        common.get_product_standard_cost(8002, '2025-06-15'::TIMESTAMP)
       ,NULL::NUMERIC
       ,'Standard cost should return NULL for date outside range'
    );

    SELECT * FROM finish();
ROLLBACK;
