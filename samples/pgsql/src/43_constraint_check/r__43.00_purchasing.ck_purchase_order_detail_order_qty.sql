DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.check_constraints AS cc
                           INNER JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_schema = cc.constraint_schema
                               AND ccu.constraint_name = cc.constraint_name
                   WHERE   ccu.constraint_schema = 'purchasing'
                           AND ccu.table_name = 'purchase_order_detail'
                           AND ccu.column_name = 'order_qty'
                           AND ccu.constraint_name = 'ck_purchase_order_detail_order_qty')
    THEN
        ALTER TABLE purchasing.purchase_order_detail
        ADD CONSTRAINT ck_purchase_order_detail_order_qty
        CHECK (order_qty > 0);
    END IF;
END$$
