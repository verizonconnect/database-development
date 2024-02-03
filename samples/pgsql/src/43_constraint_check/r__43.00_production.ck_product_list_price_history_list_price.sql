DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.check_constraints AS cc
                           INNER JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_schema = cc.constraint_schema
                               AND ccu.constraint_name = cc.constraint_name
                   WHERE   ccu.constraint_schema = 'production'
                           AND ccu.table_name = 'product_list_price_history'
                           AND ccu.column_name = 'list_price'
                           AND ccu.constraint_name = 'ck_product_list_price_history_list_price')
    THEN
        ALTER TABLE production.product_list_price_history
        ADD CONSTRAINT ck_product_list_price_history_list_price
        CHECK (list_price > 0.00);
    END IF;
END$$
