DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.check_constraints AS cc
                           INNER JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_schema = cc.constraint_schema
                               AND ccu.constraint_name = cc.constraint_name
                   WHERE   ccu.constraint_schema = 'purchasing'
                           AND ccu.table_name = 'vendor'
                           AND ccu.column_name = 'credit_rating'
                           AND ccu.constraint_name = 'ck_vendor_credit_rating')
    THEN
        ALTER TABLE purchasing.vendor
        ADD CONSTRAINT ck_vendor_credit_rating
        CHECK (credit_rating BETWEEN 1 AND 5);
    END IF;
END$$
