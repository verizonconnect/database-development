DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'sales'
                           AND tc.table_name = 'customer'
                           AND tc.constraint_name = 'fk_customer_sales_territory_territory_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE sales.customer
        ADD CONSTRAINT "fk_customer_sales_territory_territory_id"
        FOREIGN KEY (territory_id)
        REFERENCES sales.sales_territory(territory_id);
    END IF;
END$$
