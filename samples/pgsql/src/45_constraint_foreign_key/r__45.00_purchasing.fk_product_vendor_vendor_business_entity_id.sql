DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'purchasing'
                           AND tc.table_name = 'product_vendor'
                           AND tc.constraint_name = 'fk_product_vendor_vendor_business_entity_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE purchasing.product_vendor
        ADD CONSTRAINT "fk_product_vendor_vendor_business_entity_id"
        FOREIGN KEY (business_entity_id)
        REFERENCES purchasing.vendor(business_entity_id);
    END IF;
END$$
