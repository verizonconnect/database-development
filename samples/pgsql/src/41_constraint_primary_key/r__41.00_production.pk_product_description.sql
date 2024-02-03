DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'production'
                           AND tc.table_name = 'product_description'
                           AND tc.constraint_name = 'pk_product_description'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE production.product_description
        ADD CONSTRAINT "pk_product_description"
        PRIMARY KEY (product_description_id);
    END IF;
END$$
