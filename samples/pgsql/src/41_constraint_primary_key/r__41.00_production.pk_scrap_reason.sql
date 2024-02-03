DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'production'
                           AND tc.table_name = 'scrap_reason'
                           AND tc.constraint_name = 'pk_scrap_reason'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE production.scrap_reason
        ADD CONSTRAINT "pk_scrap_reason"
        PRIMARY KEY (scrap_reason_id);
    END IF;
END$$
