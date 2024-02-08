DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'purchasing'
                           AND tc.table_name = 'vendor'
                           AND tc.constraint_name = 'fk_vendor_business_entity_business_entity_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE purchasing.vendor
        ADD CONSTRAINT "fk_vendor_business_entity_business_entity_id"
        FOREIGN KEY (business_entity_id)
        REFERENCES person.business_entity(business_entity_id);
    END IF;
END$$
