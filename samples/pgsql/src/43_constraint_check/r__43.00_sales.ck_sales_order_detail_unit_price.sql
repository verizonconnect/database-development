DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.check_constraints AS cc
                           INNER JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_schema = cc.constraint_schema
                               AND ccu.constraint_name = cc.constraint_name
                   WHERE   ccu.constraint_schema = 'sales'
                           AND ccu.table_name = 'sales_order_detail'
                           AND ccu.column_name = 'unit_price'
                           AND ccu.constraint_name = 'ck_sales_order_detail_unit_price')
    THEN
        ALTER TABLE sales.sales_order_detail
        ADD CONSTRAINT ck_sales_order_detail_unit_price
        CHECK (unit_price >= 0.00);
    END IF;
END$$
