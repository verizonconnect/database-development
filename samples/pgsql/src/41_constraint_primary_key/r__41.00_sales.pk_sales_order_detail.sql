DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'sales'
                           AND tc.table_name = 'sales_order_detail'
                           AND tc.constraint_name = 'pk_sales_order_detail'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE sales.sales_order_detail
        ADD CONSTRAINT "pk_sales_order_detail"
        PRIMARY KEY (sales_order_id, sales_order_detail_id);
    END IF;
END$$
