DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.check_constraints AS cc
                           INNER JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_schema = cc.constraint_schema
                               AND ccu.constraint_name = cc.constraint_name
                   WHERE   ccu.constraint_schema = 'sales'
                           AND ccu.table_name = 'sales_tax_rate'
                           AND ccu.column_name = 'tax_type'
                           AND ccu.constraint_name = 'ck_sales_tax_rate_tax_type')
    THEN
        ALTER TABLE sales.sales_tax_rate
        ADD CONSTRAINT ck_sales_tax_rate_tax_type
        CHECK (tax_type BETWEEN 1 AND 3);
    END IF;
END$$
