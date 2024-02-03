DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'production'
                           AND tc.table_name = 'product'
                           AND tc.constraint_name = 'pk_product'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE production.product
        ADD CONSTRAINT "pk_product"
        PRIMARY KEY (product_id);
    END IF;
END$$
