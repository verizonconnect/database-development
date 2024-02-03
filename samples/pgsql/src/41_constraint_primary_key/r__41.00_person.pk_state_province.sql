DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'person'
                           AND tc.table_name = 'state_province'
                           AND tc.constraint_name = 'pk_state_province'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE person.state_province
        ADD CONSTRAINT "pk_state_province"
        PRIMARY KEY (state_province_id);
    END IF;
END$$
