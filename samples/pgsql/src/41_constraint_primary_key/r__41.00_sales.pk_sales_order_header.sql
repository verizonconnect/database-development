DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'sales'
                           AND tc.table_name = 'sales_order_header'
                           AND tc.constraint_name = 'pk_sales_order_header'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE sales.sales_order_header
        ADD CONSTRAINT "pk_sales_order_header"
        PRIMARY KEY (sales_order_id);
    END IF;
END$$
