DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.check_constraints AS cc
                           INNER JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_schema = cc.constraint_schema
                               AND ccu.constraint_name = cc.constraint_name
                   WHERE   ccu.constraint_schema = 'purchasing'
                           AND ccu.table_name = 'purchase_order_header'
                           AND ccu.column_name = 'ship_date'
                           AND ccu.constraint_name = 'ck_purchase_order_header_ship_date')
    THEN
        ALTER TABLE purchasing.purchase_order_header
        ADD CONSTRAINT ck_purchase_order_header_ship_date
        CHECK ((ship_date >= order_date) OR (ship_date IS NULL));
    END IF;
END$$
