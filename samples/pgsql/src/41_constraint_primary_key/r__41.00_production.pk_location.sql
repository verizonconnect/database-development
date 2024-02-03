DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'production'
                           AND tc.table_name = 'location'
                           AND tc.constraint_name = 'pk_location'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE production.location
        ADD CONSTRAINT "pk_location"
        PRIMARY KEY (location_id);
    END IF;
END$$
