DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'production'
                           AND tc.table_name = 'work_order'
                           AND tc.constraint_name = 'fk_work_order_scrap_reason_scrap_reason_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE production.work_order
        ADD CONSTRAINT "fk_work_order_scrap_reason_scrap_reason_id"
        FOREIGN KEY (scrap_reason_id)
        REFERENCES production.scrap_reason(scrap_reason_id);
    END IF;
END$$
