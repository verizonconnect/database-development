DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'production'
                           AND tc.table_name = 'product_cost_history'
                           AND tc.constraint_name = 'pk_product_cost_history'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE production.product_cost_history
        ADD CONSTRAINT "pk_product_cost_history"
        PRIMARY KEY (product_id, start_date);
    END IF;
END$$
