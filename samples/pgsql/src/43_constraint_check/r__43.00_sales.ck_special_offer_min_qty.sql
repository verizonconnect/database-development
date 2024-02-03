﻿DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.check_constraints AS cc
                           INNER JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_schema = cc.constraint_schema
                               AND ccu.constraint_name = cc.constraint_name
                   WHERE   ccu.constraint_schema = 'sales'
                           AND ccu.table_name = 'special_offer'
                           AND ccu.column_name = 'min_qty'
                           AND ccu.constraint_name = 'ck_special_offer_min_qty')
    THEN
        ALTER TABLE sales.special_offer
        ADD CONSTRAINT ck_special_offer_min_qty
        CHECK (min_qty >= 0);
    END IF;
END$$
