DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'purchasing'
                           AND tc.table_name = 'purchase_order_detail'
                           AND tc.constraint_name = 'pk_purchase_order_detail'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE purchasing.purchase_order_detail
        ADD CONSTRAINT "pk_purchase_order_detail"
        PRIMARY KEY (purchase_order_id, purchase_order_detail_id);
    END IF;
END$$
