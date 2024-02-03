﻿DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.check_constraints AS cc
                           INNER JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_schema = cc.constraint_schema
                               AND ccu.constraint_name = cc.constraint_name
                   WHERE   ccu.constraint_schema = 'sales'
                           AND ccu.table_name = 'sales_territory_history'
                           AND ccu.column_name = 'end_date'
                           AND ccu.constraint_name = 'ck_sales_territory_history_end_date')
    THEN
        ALTER TABLE sales.sales_territory_history
        ADD CONSTRAINT ck_sales_territory_history_end_date
        CHECK ((end_date >= start_date) OR (end_date IS NULL));
    END IF;
END$$
