﻿DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.check_constraints AS cc
                           INNER JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_schema = cc.constraint_schema
                               AND ccu.constraint_name = cc.constraint_name
                   WHERE   ccu.constraint_schema = 'sales'
                           AND ccu.table_name = 'sales_order_header'
                           AND ccu.column_name = 'freight'
                           AND ccu.constraint_name = 'ck_sales_order_header_freight')
    THEN
        ALTER TABLE sales.sales_order_header
        ADD CONSTRAINT ck_sales_order_header_freight
        CHECK (freight >= 0.00);
    END IF;
END$$
