﻿DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'production'
                           AND tc.table_name = 'product_model_illustration'
                           AND tc.constraint_name = 'pk_product_model_illustration'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE production.product_model_illustration
        ADD CONSTRAINT "pk_product_model_illustration"
        PRIMARY KEY (product_model_id, illustration_id);
    END IF;
END$$
