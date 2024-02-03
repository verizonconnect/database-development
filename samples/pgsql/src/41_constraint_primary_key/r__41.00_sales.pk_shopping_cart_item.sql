DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'sales'
                           AND tc.table_name = 'shopping_cart_item'
                           AND tc.constraint_name = 'pk_shopping_cart_item'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE sales.shopping_cart_item
        ADD CONSTRAINT "pk_shopping_cart_item"
        PRIMARY KEY (shopping_cart_item_id);
    END IF;
END$$
