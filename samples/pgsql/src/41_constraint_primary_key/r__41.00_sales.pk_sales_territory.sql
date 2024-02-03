DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'sales'
                           AND tc.table_name = 'sales_territory'
                           AND tc.constraint_name = 'pk_sales_territory'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE sales.sales_territory
        ADD CONSTRAINT "pk_sales_territory"
        PRIMARY KEY (territory_id);
    END IF;
END$$
