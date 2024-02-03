DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.check_constraints AS cc
                           INNER JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_schema = cc.constraint_schema
                               AND ccu.constraint_name = cc.constraint_name
                   WHERE   ccu.constraint_schema = 'sales'
                           AND ccu.table_name = 'sales_territory'
                           AND ccu.column_name = 'sales_ytd'
                           AND ccu.constraint_name = 'ck_sales_territory_sales_ytd')
    THEN
        ALTER TABLE sales.sales_territory
        ADD CONSTRAINT ck_sales_territory_sales_ytd
        CHECK (sales_ytd >= 0.00);
    END IF;
END$$
