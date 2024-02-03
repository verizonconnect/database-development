DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'sales'
                           AND tc.table_name = 'customer'
                           AND tc.constraint_name = 'pk_customer'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE sales.customer
        ADD CONSTRAINT "pk_customer"
        PRIMARY KEY (customer_id);
    END IF;
END$$
