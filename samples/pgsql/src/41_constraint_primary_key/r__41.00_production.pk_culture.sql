DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'production'
                           AND tc.table_name = 'culture'
                           AND tc.constraint_name = 'pk_culture'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE production.culture
        ADD CONSTRAINT "pk_culture"
        PRIMARY KEY (culture_id);
    END IF;
END$$
