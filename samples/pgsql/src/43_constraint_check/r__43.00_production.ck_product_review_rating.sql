DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.check_constraints AS cc
                           INNER JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_schema = cc.constraint_schema
                               AND ccu.constraint_name = cc.constraint_name
                   WHERE   ccu.constraint_schema = 'production'
                           AND ccu.table_name = 'product_review'
                           AND ccu.column_name = 'rating'
                           AND ccu.constraint_name = 'ck_product_review_rating')
    THEN
        ALTER TABLE production.product_review
        ADD CONSTRAINT ck_product_review_rating
        CHECK (rating BETWEEN 1 AND 5);
    END IF;
END$$
