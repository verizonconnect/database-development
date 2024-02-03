DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.check_constraints AS cc
                           INNER JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_schema = cc.constraint_schema
                               AND ccu.constraint_name = cc.constraint_name
                   WHERE   ccu.constraint_schema = 'purchasing'
                           AND ccu.table_name = 'ship_method'
                           AND ccu.column_name = 'ship_base'
                           AND ccu.constraint_name = 'ck_ship_method_ship_base')
    THEN
        ALTER TABLE purchasing.ship_method
        ADD CONSTRAINT ck_ship_method_ship_base
        CHECK (ship_base > 0.00);
    END IF;
END$$
