DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'production'
                           AND tc.table_name = 'work_order'
                           AND tc.constraint_name = 'pk_work_order'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE production.work_order
        ADD CONSTRAINT "pk_work_order"
        PRIMARY KEY (work_order_id);
    END IF;
END$$
