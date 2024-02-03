DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'production'
                           AND tc.table_name = 'product_product_photo'
                           AND tc.constraint_name = 'pk_product_product_photo'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE production.product_product_photo
        ADD CONSTRAINT "pk_product_product_photo"
        PRIMARY KEY (product_id, product_photo_id);
    END IF;
END$$
