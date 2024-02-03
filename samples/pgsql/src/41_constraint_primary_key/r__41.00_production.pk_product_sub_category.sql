DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'production'
                           AND tc.table_name = 'product_sub_category'
                           AND tc.constraint_name = 'pk_product_sub_category'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE production.product_sub_category
        ADD CONSTRAINT "pk_product_sub_category"
        PRIMARY KEY (product_sub_category_id);
    END IF;
END$$
