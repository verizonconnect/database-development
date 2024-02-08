DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'sales'
                           AND tc.table_name = 'store'
                           AND tc.constraint_name = 'fk_store_sales_person_sales_person_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE sales.store
        ADD CONSTRAINT "fk_store_sales_person_sales_person_id"
        FOREIGN KEY (sales_person_id)
        REFERENCES sales.sales_person(business_entity_id);
    END IF;
END$$
