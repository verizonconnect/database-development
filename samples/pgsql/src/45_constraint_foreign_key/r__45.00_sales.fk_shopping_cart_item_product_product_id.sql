DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'sales'
                           AND tc.table_name = 'shopping_cart_item'
                           AND tc.constraint_name = 'fk_shopping_cart_item_product_product_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE sales.shopping_cart_item
        ADD CONSTRAINT "fk_shopping_cart_item_product_product_id"
        FOREIGN KEY (product_id)
        REFERENCES production.product(product_id);
    END IF;
END$$
