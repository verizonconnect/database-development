DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'production'
                           AND tc.table_name = 'product_product_photo'
                           AND tc.constraint_name = 'fk_product_product_photo_product_photo_product_photo_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE production.product_product_photo
        ADD CONSTRAINT "fk_product_product_photo_product_photo_product_photo_id"
        FOREIGN KEY (product_photo_id)
        REFERENCES production.product_photo(product_photo_id);
    END IF;
END$$
