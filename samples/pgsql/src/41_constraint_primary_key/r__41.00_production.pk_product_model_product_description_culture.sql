DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'production'
                           AND tc.table_name = 'product_model_product_description_culture'
                           AND tc.constraint_name = 'pk_product_model_product_description_culture'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE production.product_model_product_description_culture
        ADD CONSTRAINT "pk_product_model_product_description_culture"
        PRIMARY KEY (product_model_id, product_description_id, culture_id);
    END IF;
END$$
