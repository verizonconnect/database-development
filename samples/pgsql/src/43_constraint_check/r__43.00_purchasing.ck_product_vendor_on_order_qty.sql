DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.check_constraints AS cc
                           INNER JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_schema = cc.constraint_schema
                               AND ccu.constraint_name = cc.constraint_name
                   WHERE   ccu.constraint_schema = 'purchasing'
                           AND ccu.table_name = 'product_vendor'
                           AND ccu.column_name = 'on_order_qty'
                           AND ccu.constraint_name = 'ck_product_vendor_on_order_qty')
    THEN
        ALTER TABLE purchasing.product_vendor
        ADD CONSTRAINT ck_product_vendor_on_order_qty
        CHECK (on_order_qty >= 0);
    END IF;
END$$
