DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'purchasing'
                           AND tc.table_name = 'purchase_order_header'
                           AND tc.constraint_name = 'fk_purchase_order_header_vendor_vendor_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE purchasing.purchase_order_header
        ADD CONSTRAINT "fk_purchase_order_header_vendor_vendor_id"
        FOREIGN KEY (vendor_id)
        REFERENCES purchasing.vendor(business_entity_id);
    END IF;
END$$
