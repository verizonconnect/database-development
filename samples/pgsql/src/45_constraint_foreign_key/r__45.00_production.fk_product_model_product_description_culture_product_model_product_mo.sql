DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'production'
                           AND tc.table_name = 'product_model_product_description_culture'
                           AND tc.constraint_name = 'fk_product_model_product_description_culture_product_model_product_mo'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE production.product_model_product_description_culture
        ADD CONSTRAINT "fk_product_model_product_description_culture_product_model_product_mo"
        FOREIGN KEY (product_model_id)
        REFERENCES production.product_model(product_model_id);
    END IF;
END$$
