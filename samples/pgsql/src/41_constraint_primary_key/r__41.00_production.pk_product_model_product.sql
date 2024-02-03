DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'production'
                           AND tc.table_name = 'product_model'
                           AND tc.constraint_name = 'pk_product_model_product'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE production.product_model
        ADD CONSTRAINT "pk_product_model_product"
        PRIMARY KEY (product_model_id);
    END IF;
END$$
