SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
    SELECT plan(2);

    -- assemble phase: assembly (7001) made from component (7002)
    INSERT INTO production.product (
        product_id, name, product_number, safety_stock_level
       ,reorder_point, standard_cost, list_price, days_to_manufacture
       ,sell_start_date
    ) VALUES
        (7001, 'Bicycle', 'BK-7001', 10, 5, 100.00, 200.00, 3, '2024-01-01')
       ,(7002, 'Wheel', 'WH-7002', 20, 10, 25.00, 50.00, 1, '2024-01-01');

    INSERT INTO production.unit_measure (unit_measure_code, name) VALUES ('EA ', 'Each');

    INSERT INTO production.bill_of_materials (
        product_assembly_id, component_id, start_date, end_date
       ,unit_measure_code, bom_level, per_assembly_qty
    ) VALUES (
        7001, 7002, '2024-01-01', NULL, 'EA ', 1, 2.00
    );

    -- act / assert phase

    -- Test 1: get_bill_of_materials returns the component
    SELECT results_eq(
        $$SELECT component_id, total_quantity::NUMERIC(8,2), bom_level
          FROM production.get_bill_of_materials(7001, '2024-06-15'::TIMESTAMP)$$
       ,$$VALUES (7002, 2.00::NUMERIC(8,2), 1::SMALLINT)$$
       ,'BOM should return component 7002 with qty 2'
    );

    -- Test 2: get_where_used returns the assembly for a given component
    SELECT results_eq(
        $$SELECT product_assembly_id, total_quantity::NUMERIC(8,2), bom_level
          FROM common.get_where_used__product_id(7002, '2024-06-15'::TIMESTAMP)$$
       ,$$VALUES (7001, 2.00::NUMERIC(8,2), 1::SMALLINT)$$
       ,'Where-used should return assembly 7001 for component 7002'
    );

    SELECT * FROM finish();
ROLLBACK;
