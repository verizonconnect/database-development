DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'sales'
                           AND tc.table_name = 'store'
                           AND tc.constraint_name = 'fk_store_business_entity_business_entity_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE sales.store
        ADD CONSTRAINT "fk_store_business_entity_business_entity_id"
        FOREIGN KEY (business_entity_id)
        REFERENCES person.business_entity(business_entity_id);
    END IF;
END$$
