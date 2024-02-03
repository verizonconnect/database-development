﻿DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.check_constraints AS cc
                           INNER JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_schema = cc.constraint_schema
                               AND ccu.constraint_name = cc.constraint_name
                   WHERE   ccu.constraint_schema = 'sales'
                           AND ccu.table_name = 'sales_person'
                           AND ccu.column_name = 'sales_last_year'
                           AND ccu.constraint_name = 'ck_sales_person_sales_last_year')
    THEN
        ALTER TABLE sales.sales_person
        ADD CONSTRAINT ck_sales_person_sales_last_year
        CHECK (sales_last_year >= 0.00);
    END IF;
END$$
