DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'purchasing'
                           AND tc.table_name = 'purchase_order_header'
                           AND tc.constraint_name = 'pk_purchase_order_header'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE purchasing.purchase_order_header
        ADD CONSTRAINT "pk_purchase_order_header"
        PRIMARY KEY (purchase_order_id);
    END IF;
END$$
