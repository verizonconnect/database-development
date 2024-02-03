DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.check_constraints AS cc
                           INNER JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_schema = cc.constraint_schema
                               AND ccu.constraint_name = cc.constraint_name
                   WHERE   ccu.constraint_schema = 'production'
                           AND ccu.table_name = 'work_order'
                           AND ccu.column_name = 'end_date'
                           AND ccu.constraint_name = 'ck_work_order_end_date')
    THEN
        ALTER TABLE production.work_order
        ADD CONSTRAINT ck_work_order_end_date
        CHECK ((end_date >= start_date) OR (end_date IS NULL));
    END IF;
END$$
