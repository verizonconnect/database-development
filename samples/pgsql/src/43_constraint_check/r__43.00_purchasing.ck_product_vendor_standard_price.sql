DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.check_constraints AS cc
                           INNER JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_schema = cc.constraint_schema
                               AND ccu.constraint_name = cc.constraint_name
                   WHERE   ccu.constraint_schema = 'purchasing'
                           AND ccu.table_name = 'product_vendor'
                           AND ccu.column_name = 'standard_price'
                           AND ccu.constraint_name = 'ck_product_vendor_standard_price')
    THEN
        ALTER TABLE purchasing.product_vendor
        ADD CONSTRAINT ck_product_vendor_standard_price
        CHECK (standard_price > 0.00);
    END IF;
END$$
