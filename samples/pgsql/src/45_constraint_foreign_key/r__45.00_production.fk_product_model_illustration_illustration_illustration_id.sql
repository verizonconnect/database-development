DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'production'
                           AND tc.table_name = 'product_model_illustration'
                           AND tc.constraint_name = 'fk_product_model_illustration_illustration_illustration_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE production.product_model_illustration
        ADD CONSTRAINT "fk_product_model_illustration_illustration_illustration_id"
        FOREIGN KEY (illustration_id)
        REFERENCES production.illustration(illustration_id);
    END IF;
END$$
