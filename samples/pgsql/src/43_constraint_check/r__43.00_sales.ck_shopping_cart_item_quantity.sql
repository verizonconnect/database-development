DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.check_constraints AS cc
                           INNER JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_schema = cc.constraint_schema
                               AND ccu.constraint_name = cc.constraint_name
                   WHERE   ccu.constraint_schema = 'sales'
                           AND ccu.table_name = 'shopping_cart_item'
                           AND ccu.column_name = 'quantity'
                           AND ccu.constraint_name = 'ck_shopping_cart_item_quantity')
    THEN
        ALTER TABLE sales.shopping_cart_item
        ADD CONSTRAINT ck_shopping_cart_item_quantity
        CHECK (quantity >= 1);
    END IF;
END$$
