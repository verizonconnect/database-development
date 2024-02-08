DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'sales'
                           AND tc.table_name = 'sales_order_header_sales_reason'
                           AND tc.constraint_name = 'fk_sales_order_header_sales_reason_sales_order_header_sales_order_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE sales.sales_order_header_sales_reason
        ADD CONSTRAINT "fk_sales_order_header_sales_reason_sales_order_header_sales_order_id"
        FOREIGN KEY (sales_order_id)
        REFERENCES sales.sales_order_header(sales_order_id) ON DELETE CASCADE;
    END IF;
END$$
