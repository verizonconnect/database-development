DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'sales'
                           AND tc.table_name = 'sales_order_header_sales_reason'
                           AND tc.constraint_name = 'fk_sales_order_header_sales_reason_sales_reason_sales_reason_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE sales.sales_order_header_sales_reason
        ADD CONSTRAINT "fk_sales_order_header_sales_reason_sales_reason_sales_reason_id"
        FOREIGN KEY (sales_reason_id)
        REFERENCES sales.sales_reason(sales_reason_id);
    END IF;
END$$
