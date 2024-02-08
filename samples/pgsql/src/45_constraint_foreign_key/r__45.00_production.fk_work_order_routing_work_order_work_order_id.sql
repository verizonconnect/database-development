DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'production'
                           AND tc.table_name = 'work_order_routing'
                           AND tc.constraint_name = 'fk_work_order_routing_work_order_work_order_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE production.work_order_routing
        ADD CONSTRAINT "fk_work_order_routing_work_order_work_order_id"
        FOREIGN KEY (work_order_id)
        REFERENCES production.work_order(work_order_id);
    END IF;
END$$
