DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.check_constraints AS cc
                           INNER JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_schema = cc.constraint_schema
                               AND ccu.constraint_name = cc.constraint_name
                   WHERE   ccu.constraint_schema = 'purchasing'
                           AND ccu.table_name = 'purchase_order_header'
                           AND ccu.column_name = 'status'
                           AND ccu.constraint_name = 'ck_purchase_order_header_status')
    THEN
        ALTER TABLE purchasing.purchase_order_header
        ADD CONSTRAINT ck_purchase_order_header_status
        CHECK (status BETWEEN 1 AND 4); -- 1 = pending; 2 = approved; 3 = rejected; 4 = complete;
    END IF;
END$$
