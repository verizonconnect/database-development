DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'production'
                           AND tc.table_name = 'product_cost_history'
                           AND tc.constraint_name = 'fk_product_cost_history_product_product_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE production.product_cost_history
        ADD CONSTRAINT "fk_product_cost_history_product_product_id"
        FOREIGN KEY (product_id)
        REFERENCES production.product(product_id);
    END IF;
END$$
