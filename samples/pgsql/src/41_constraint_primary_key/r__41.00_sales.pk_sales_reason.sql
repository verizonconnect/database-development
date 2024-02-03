DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'sales'
                           AND tc.table_name = 'sales_reason'
                           AND tc.constraint_name = 'pk_sales_reason'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE sales.sales_reason
        ADD CONSTRAINT "pk_sales_reason"
        PRIMARY KEY (sales_reason_id);
    END IF;
END$$
