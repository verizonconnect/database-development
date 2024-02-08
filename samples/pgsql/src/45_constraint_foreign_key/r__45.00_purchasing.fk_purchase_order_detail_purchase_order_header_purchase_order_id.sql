DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'purchasing'
                           AND tc.table_name = 'purchase_order_detail'
                           AND tc.constraint_name = 'fk_purchase_order_detail_purchase_order_header_purchase_order_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE purchasing.purchase_order_detail
        ADD CONSTRAINT "fk_purchase_order_detail_purchase_order_header_purchase_order_id"
        FOREIGN KEY (purchase_order_id)
        REFERENCES purchasing.purchase_order_header(purchase_order_id);
    END IF;
END$$
