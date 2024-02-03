DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'purchasing'
                           AND tc.table_name = 'vendor'
                           AND tc.constraint_name = 'pk_vendor'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE purchasing.vendor
        ADD CONSTRAINT "pk_vendor"
        PRIMARY KEY (business_entity_id);
    END IF;
END$$
