DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.check_constraints AS cc
                           INNER JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_schema = cc.constraint_schema
                               AND ccu.constraint_name = cc.constraint_name
                   WHERE   ccu.constraint_schema = 'production'
                           AND ccu.table_name = 'location'
                           AND ccu.column_name = 'availability'
                           AND ccu.constraint_name = 'ck_location_availability')
    THEN
        ALTER TABLE production.location
        ADD CONSTRAINT ck_location_availability
        CHECK (availability >= 0.00);
    END IF;
END$$
