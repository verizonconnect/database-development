DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'production'
                           AND tc.table_name = 'product_inventory'
                           AND tc.constraint_name = 'pk_product_inventory'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE production.product_inventory
        ADD CONSTRAINT "pk_product_inventory"
        PRIMARY KEY (product_id, location_id);
    END IF;
END$$
