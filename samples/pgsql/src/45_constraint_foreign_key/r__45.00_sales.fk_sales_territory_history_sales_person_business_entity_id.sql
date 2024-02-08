DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'sales'
                           AND tc.table_name = 'sales_territory_history'
                           AND tc.constraint_name = 'fk_sales_territory_history_sales_person_business_entity_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE sales.sales_territory_history
        ADD CONSTRAINT "fk_sales_territory_history_sales_person_business_entity_id"
        FOREIGN KEY (business_entity_id)
        REFERENCES sales.sales_person(business_entity_id);
    END IF;
END$$
