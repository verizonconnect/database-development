DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'purchasing'
                           AND tc.table_name = 'product_vendor'
                           AND tc.constraint_name = 'pk_product_vendor'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE purchasing.product_vendor
        ADD CONSTRAINT "pk_product_vendor"
        PRIMARY KEY (product_id, business_entity_id);
    END IF;
END$$
