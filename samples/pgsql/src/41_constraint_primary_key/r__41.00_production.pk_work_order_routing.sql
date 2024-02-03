DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'production'
                           AND tc.table_name = 'work_order_routing'
                           AND tc.constraint_name = 'pk_work_order_routing'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE production.work_order_routing
        ADD CONSTRAINT "pk_work_order_routing"
        PRIMARY KEY (work_order_id, product_id, operation_sequence);
    END IF;
END$$
