DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.check_constraints AS cc
                           INNER JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_schema = cc.constraint_schema
                               AND ccu.constraint_name = cc.constraint_name
                   WHERE   ccu.constraint_schema = 'production'
                           AND ccu.table_name = 'location'
                           AND ccu.column_name = 'cost_rate'
                           AND ccu.constraint_name = 'ck_location_cost_rate')
    THEN
        ALTER TABLE production.location
        ADD CONSTRAINT ck_location_cost_rate
        CHECK (cost_rate >= 0.00);
    END IF;
END$$
