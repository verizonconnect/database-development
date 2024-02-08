DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'sales'
                           AND tc.table_name = 'customer'
                           AND tc.constraint_name = 'fk_customer_store_store_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE sales.customer
        ADD CONSTRAINT "fk_customer_store_store_id"
        FOREIGN KEY (store_id)
        REFERENCES sales.store(business_entity_id);
    END IF;
END$$
