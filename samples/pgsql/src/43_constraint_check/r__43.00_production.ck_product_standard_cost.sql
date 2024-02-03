DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.check_constraints AS cc
                           INNER JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_schema = cc.constraint_schema
                               AND ccu.constraint_name = cc.constraint_name
                   WHERE   ccu.constraint_schema = 'production'
                           AND ccu.table_name = 'product'
                           AND ccu.column_name = 'standard_cost'
                           AND ccu.constraint_name = 'ck_product_standard_cost')
    THEN
        ALTER TABLE production.product
        ADD CONSTRAINT ck_product_standard_cost
        CHECK (standard_cost >= 0.00);
    END IF;
END$$
