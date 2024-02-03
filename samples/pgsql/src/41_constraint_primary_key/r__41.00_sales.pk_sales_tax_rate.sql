DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'sales'
                           AND tc.table_name = 'sales_tax_rate'
                           AND tc.constraint_name = 'pk_sales_tax_rate'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE sales.sales_tax_rate
        ADD CONSTRAINT "pk_sales_tax_rate"
        PRIMARY KEY (sales_tax_rate_id);
    END IF;
END$$
