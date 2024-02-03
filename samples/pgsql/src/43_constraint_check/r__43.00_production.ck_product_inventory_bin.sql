DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.check_constraints AS cc
                           INNER JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_schema = cc.constraint_schema
                               AND ccu.constraint_name = cc.constraint_name
                   WHERE   ccu.constraint_schema = 'production'
                           AND ccu.table_name = 'product_inventory'
                           AND ccu.column_name = 'bin'
                           AND ccu.constraint_name = 'ck_product_inventory_bin')
    THEN
        ALTER TABLE production.product_inventory
        ADD CONSTRAINT ck_product_inventory_bin
        CHECK (bin BETWEEN 0 AND 100);
    END IF;
END$$
