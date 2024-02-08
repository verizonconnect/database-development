DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'production'
                           AND tc.table_name = 'product_model_product_description_culture'
                           AND tc.constraint_name = 'fk_product_model_product_description_culture_culture_culture_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE production.product_model_product_description_culture
        ADD CONSTRAINT "fk_product_model_product_description_culture_culture_culture_id"
        FOREIGN KEY (culture_id)
        REFERENCES production.culture(culture_id);
    END IF;
END$$
