DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.check_constraints AS cc
                           INNER JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_schema = cc.constraint_schema
                               AND ccu.constraint_name = cc.constraint_name
                   WHERE   ccu.constraint_schema = 'production'
                           AND ccu.table_name = 'work_order_routing'
                           AND ccu.column_name = 'actual_resource_hrs'
                           AND ccu.constraint_name = 'ck_work_order_routing_actual_resource_hrs')
    THEN
        ALTER TABLE production.work_order_routing
        ADD CONSTRAINT ck_work_order_routing_actual_resource_hrs
        CHECK (actual_resource_hrs >= 0.0000);
    END IF;
END$$
