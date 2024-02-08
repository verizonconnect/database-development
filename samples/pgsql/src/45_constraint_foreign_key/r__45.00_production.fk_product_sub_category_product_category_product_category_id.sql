DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'production'
                           AND tc.table_name = 'product_sub_category'
                           AND tc.constraint_name = 'fk_product_sub_category_product_category_product_category_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE production.product_sub_category
        ADD CONSTRAINT "fk_product_sub_category_product_category_product_category_id"
        FOREIGN KEY (product_category_id)
        REFERENCES production.product_category(product_category_id);
    END IF;
END$$
