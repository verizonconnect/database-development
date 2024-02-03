DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'production'
                           AND tc.table_name = 'illustration'
                           AND tc.constraint_name = 'pk_illustration'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE production.illustration
        ADD CONSTRAINT "pk_illustration"
        PRIMARY KEY (illustration_id);
    END IF;
END$$
