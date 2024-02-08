DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'production'
                           AND tc.table_name = 'product'
                           AND tc.constraint_name = 'fk_product_product_sub_category_product_sub_category_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE production.product
        ADD CONSTRAINT "fk_product_product_sub_category_product_sub_category_id"
        FOREIGN KEY (product_sub_category_id)
        REFERENCES production.product_sub_category(product_sub_category_id);
    END IF;
END$$
