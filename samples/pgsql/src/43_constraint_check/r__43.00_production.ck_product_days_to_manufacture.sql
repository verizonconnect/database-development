DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.check_constraints AS cc
                           INNER JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_schema = cc.constraint_schema
                               AND ccu.constraint_name = cc.constraint_name
                   WHERE   ccu.constraint_schema = 'production'
                           AND ccu.table_name = 'product'
                           AND ccu.column_name = 'days_to_manufacture'
                           AND ccu.constraint_name = 'ck_product_days_to_manufacture')
    THEN
        ALTER TABLE production.product
        ADD CONSTRAINT ck_product_days_to_manufacture
        CHECK (days_to_manufacture >= 0);
    END IF;
END$$
