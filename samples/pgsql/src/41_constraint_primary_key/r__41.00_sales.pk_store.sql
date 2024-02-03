DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'sales'
                           AND tc.table_name = 'store'
                           AND tc.constraint_name = 'pk_store'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE sales.store
        ADD CONSTRAINT "pk_store"
        PRIMARY KEY (business_entity_id);
    END IF;
END$$
